<?php
/**
 * Copyright Intermesh
 *
 * This file is part of Group-Office. You should have received a copy of the
 * Group-Office license along with Group-Office. See the file /LICENSE.TXT
 *
 * If you have questions write an e-mail to info@intermesh.nl
 *
 * @version $Id: File.class.inc.php 7607 2011-06-15 09:17:42Z mschering $
 * @copyright Copyright Intermesh
 * @author Merijn Schering <mschering@intermesh.nl>
 */

/**
 * 
 * The Custom fields record model
 */



namespace GO\Customfields\Model;


abstract class AbstractCustomFieldsRecord extends \GO\Base\Db\ActiveRecord{
	
	/**
	 * Some fields need different formatting when exporting like contact fields that are prefixed with the ID.
	 * 
	 * @var boolean 
	 */
	public static $formatForExport=false;
	
	public static $cacheColumns = array();
	public static $attributeLabels = array();
		
	public function primaryKey(){
			return 'model_id';
	}	
	
	public function init(){
		//$className = $this->className();
		$this->_getAllFields();		
		return parent::init();
	}
	
	public function tableName(){
		return 'cf_'.$this->getExtendedModel()->tableName();
	}
	
	/**
	 * Return the static model this custom fields model extends with fields.
	 * 
	 * @return \GO\Base\Db\ActiveRecord 
	 */
	public function getExtendedModel(){
		return call_user_func(array($this->extendsModel(),'model'));
	}
	
	public function getModel() {
		$model = $this->getExtendedModel()->findByPk($this->model_id,false,true);
		if(!$model)
			$model = $this->getExtendedModel();
		return $model;
	}
	
	/**
	 * Override this to return the model this custom fields model extends with fields.
	 * 
	 * @return \GO\Base\Db\ActiveRecord 
	 */
	protected function extendsModel(){
		return false;
	}
	
	private function getCacheKey(){
		return 'customfields_'.$this->extendsModel();
	}
	
	
	/**
	 * Returns all custom fields for this link type
	 * 
	 * @param int $linkType
	 * @return PDOStatement 
	 */
	private function _getAllFields() {
		
		//cache is cleared when a field is saved or deleted in Field::AfterSave and afterdelete
		if(!isset(self::$cacheColumns[$this->extendsModel()])){
			$cacheKey = $this->getCacheKey();

			if($cached = \GO::cache()->get($cacheKey)){				
				self::$attributeLabels[$this->extendsModel()]=$cached['attributeLabels'];
				self::$cacheColumns[$this->extendsModel()]=$cached['columns'];
			}else
			{			
				$findParams = \GO\Base\Db\FindParams::newInstance()
								->select('t.*')
								->ignoreAcl()
								->joinRelation('category');
				
				$findParams->getCriteria()->addCondition('extends_model', $this->extendsModel(),'=','category');
				
				$stmt = \GO\Customfields\Model\Field::model()->find($findParams);
				
				self::$cacheColumns[$this->extendsModel()]=\GO\Base\Db\Columns::getColumns ($this);
				self::$attributeLabels[$this->extendsModel()]=array();
				
				while($field = $stmt->fetch()){			

					self::$attributeLabels[$this->extendsModel()][$field->columnName()]=$field->category->name.':'.$field->name;

					self::$cacheColumns[$this->extendsModel()][$field->columnName()]['customfield']=$field;
					self::$cacheColumns[$this->extendsModel()][$field->columnName()]['regex']=$field->validation_regex;
					self::$cacheColumns[$this->extendsModel()][$field->columnName()]['gotype']='customfield';
					self::$cacheColumns[$this->extendsModel()][$field->columnName()]['unique']=$field->unique_values;
	
					//Don't validate required on the server side because customfields tabs can be disabled.
					//self::$cacheColumns[$this->extendsModel()][$field->columnName()]['required']=$field->required;

				}

				\GO::cache()->set($cacheKey, array('attributeLabels'=>self::$attributeLabels[$this->extendsModel()], 'columns'=>self::$cacheColumns[$this->extendsModel()]));
			}
		}
		
		$this->columns=self::$cacheColumns[$this->extendsModel()];	
		
	}
	
	/**
	 * Get all default select fields. It excludes BLOBS and TEXT fields.
	 * This function is used by find.
	 * 
	 * @param boolean $single
	 * @param StringHelper $tableAlias
	 * @return StringHelper 
	 */
	public function getDefaultFindSelectFields($single=false, $tableAlias='t'){
		
		// This is changed so that textarea fields are also returned.
		// This was needed to make the external api be able to return all data
		
		return $tableAlias.'.*';
//		if($single)
//			return $tableAlias.'.*';
//		
//		$fields=array();
//		
//		foreach($this->columns as $name=>$attr){
//			if($attr['gotype']=='customfield' && !$attr['customfield']->exclude_from_grid && $attr['customfield']->customfieldtype->selectForGrid())
//				$fields[]=$name;
//		}		
//		
//		return count($fields) ? "`$tableAlias`.`".implode('`, `'.$tableAlias.'`.`', $fields)."`" : "";
	}
	
	public function validate() {
		
		$fieldsToCheck = $this->isNew ? array_keys($this->columns) : array_keys($this->getModifiedAttributes());
		
		foreach($fieldsToCheck as $field){

			if(!empty($this->columns[$field]['customfield'])){
//				var_dump($field);
//				var_dump($this->columns[$field]['customfield']->datatype);
//				echo '<br />'.$this->$field.'<br />';
				if(!$this->columns[$field]['customfield']->customfieldType->validate($this->$field)) {
					$this->setValidationError ($field, $this->columns[$field]['customfield']->customfieldType->getValidationError());
				}
			}
		}
		
		return parent::validate();
	}
	
	public function attributeLabels() {
		return self::$attributeLabels[$this->extendsModel()];
	}
	
	public function getAttributeLabelWithoutCategoryName($attribute) {
		$label = parent::getAttributeLabel($attribute);
		$pos = strpos($label,':');
		if($pos){
			$label=substr($label, $pos+1);
		}
		return $label;
	}
	
	/**
	 * Copy custom fields if the label matches. Eg.:
	 * A company and an invoice model have a field with label "Customer No.:".
	 * 
	 * With this function we can easily copy that value.
	 * 
	 * @param AbstractCustomFieldsRecord $source
	 */
	public function copyAttributesWithMatchingAttributeLabels(AbstractCustomFieldsRecord $copyFrom){
		$sourceColumns = $copyFrom->attributeLabels();
		unset($sourceColumns['model_id']);
		//flip keys and values
		$targetColumns = array_flip($this->attributeLabels());

		foreach($sourceColumns as $col=>$label){
			if(isset($targetColumns[$label])){
//				echo $targetColumns[$label].': '.$copyFrom->$col.'<br>';
				$this->{$targetColumns[$label]}=$copyFrom->$col;
			}
		}
		$this->save();
	}
	
	public function formatInput($column, $value) {		
		if(isset($this->columns[$column]['customfield'])){
			$field = $this->columns[$column]['customfield'];
			
			//dirty, rawposted values not there because formatinputvalues was not called.
			// formatInput should always return the formatted value of $valuecd 
			//if(empty($this->_rawPostedAttributes[$column]))
				$this->_rawPostedAttributes[$column]=$value;
			
			return $field->customfieldtype->formatFormInput($column, $this->_rawPostedAttributes, $this);			
		}else
		{		
			return parent::formatInput($column, $value);
		}
	}
	
	protected $_rawPostedAttributes;
	
	protected function formatInputValues($attributes) {
		
		$this->_rawPostedAttributes=$attributes;
		
		return parent::formatInputValues($attributes);

	}
		
//	protected function formatOutputValues($attributes, $html = false) {
//		$attributes = parent::formatOutputValues($attributes, $html);
//		
//		foreach($attributes as $key=>&$value){			
//			//implode array values with pipes for multiselect fields
//			if(is_array($value))
//				$value=implode('|',$value);
//			if(isset($this->columns[$key]['customfield'])){
//				$field = $this->columns[$key]['customfield'];
//				if($html)
//					$attributes[$key]=$field->customfieldtype->formatDisplay($key, $attributes);			
//				else
//					$attributes[$key]=$field->customfieldtype->formatFormOutput($key, $attributes);			
//			}
//		}		
//		
//		return $attributes;
//	}
	
	/**
	 * Get a single attibute raw like in the database or formatted using the \
	 * Group-Office user preferences.
	 * 
	 * @param String $attributeName
	 * @param String $outputType raw, formatted or html
	 * @return mixed 
	 */
	public function getAttribute($attributeName, $outputType='raw'){
		if(!key_exists($attributeName, $this->_attributes))						
			return false;
		
		if($outputType=='raw'){
			if(isset($this->columns[$attributeName]['customfield'])){
				$field = $this->columns[$attributeName]['customfield'];
				return $field->customfieldtype->formatRawOutput($attributeName, $this->_attributes, $this);	
			}else
			{
				return $this->_attributes[$attributeName];
			}
		}else{		
		
			return $this->formatAttribute($attributeName, $this->_attributes[$attributeName],$outputType=='html');
		}
	}
	
	public function formatAttribute($attributeName, $value, $html = false) {
		
		if(isset($this->columns[$attributeName]['customfield'])){
			$field = $this->columns[$attributeName]['customfield'];
			//$attributes = $this->getAttributes('raw');
			if($html)
				return $field->customfieldtype->formatDisplay($attributeName, $this->_attributes, $this);			
			else
				return $field->customfieldtype->formatFormOutput($attributeName, $this->_attributes, $this);			
		}
		return parent::formatAttribute($attributeName, $value, $html);
	}
	
	/**
	 * Convert a key value array of custom field values with there label as key,
	 * to a key value array with the database field name as key so we can use it
	 * in the customfieldsrecord model in setAttributes.
	 * 
	 * eg. array('SomeLabel'=>'somevalue') -> array('col_1','somevalue')
	 * 
	 * @param String $categoryName
	 * @param array $labelValueArray
	 * @return array 
	 */
	public function convertLabelKeyAttributes($categoryName, $labelValueArray) {

		$stmt = Field::model()->find(array(
				'ignoreAcl' => true,
				'join' => 'INNER JOIN cf_categories c ON (t.category_id=c.id AND c.name=:categoryName)',
				'where' => 'c.extends_model=:extends_model',
				'bindParams' => array('extends_model' => $this->extendsModel(), 'categoryName' => $categoryName)
						));

		$fieldValueArray = array();

		while ($field = $stmt->fetch()) {
			if (isset($labelValueArray[$field->name])) {
				$fieldValueArray[$field->columnName()] = $labelValueArray[$field->name];
			}
		}

		return $fieldValueArray;
	}
	
	/**
	 * Get the value of a custom attribute by category and field name
	 * 
	 * @param StringHelper $categoryName
	 * @param StringHelper $fieldName
	 * @return mixed 
	 */
	public function getAttributeByName($categoryName, $fieldName, $outputType='raw'){

		$category = Category::model()->findSingleByAttributes(array(
				'extends_model'=>$this->extendsModel(),
				'name'=>$categoryName
		));
		
		$field = Field::model()->findSingleByAttributes(array(
				'category_id'=>$category->id,
				'name'=>$fieldName
		));
		if($field)
			return $this->getAttribute($field->columnName(), $outputType);
		else
			return false;
	}
	
	/**
	 * Instead of having to look up the column number in order to get the custom
	 * field's value, you can let this function look up a custom field value for
	 * you by using the field name.
	 * @param StringHelper $fieldNameString The name of the custom field you want the value of.
	 * @param StringHelper $categoryNameString (Optional) The name of the custom field's category.
	 * @return StringHelper 
	 */
	public function getValueByName($fieldNameString,$categoryNameString='') {		

		$colId = $this->getColIdByName($fieldNameString, $categoryNameString);
		if ($colId>0) {
			$colName = 'col_'.$colId;
			return $this->$colName;
		} else {
			return false;
		}
	}
	
	/**
	 * Function that lets you set a custom field that is selected by its name (and,
	 * optionally, the category name), instead of the col id.
	 * @param StringHelper $fieldNameString The name of the custom field you want the value of.
	 * @param value $value The value to set this custom field to.
	 * @param StringHelper $categoryNameString (Optional) The name of the custom field's category.
	 */
	public function setValueByName($fieldNameString,$value,$categoryNameString='', $save=true) {
		$colId = $this->getColIdByName($fieldNameString, $categoryNameString);
		if ($colId>0) {
			$colName = 'col_'.$colId;
			$this->$colName = $value;
			if($save && !$this->save()) {
				\GO::debug('Save failed in '.$this->className().' when setting '.$fieldNameString.' in the category:'.$categoryNameString);
			}	
		} else {
			\GO::debug('Customfield:'.$this->className().' - Could not find field: '.$fieldNameString.' in the category:'.$categoryNameString);
		}
	}
	
	public function getColIdByName($fieldNameString,$categoryNameString='') {
		$findParams = \GO\Base\Db\FindParams::newInstance()
				->single()
				->select('`t`.`id`')
				->joinModel(array(
					'model' => 'GO\Customfields\Model\Category',
					'localTableAlias' => 't',
					'localField' => 'category_id',
					'foreignField' => 'id',
					'tableAlias' => 'cat'
				));

		$findCriteria = \GO\Base\Db\FindCriteria::newInstance()
						->addCondition('name', $fieldNameString, '=', 't')
						->addCondition('extends_model', $this->getExtendedModel()->className(), '=', 'cat');
		if (!empty($categoryNameString))
			$findCriteria->addCondition('name',$categoryNameString, '=','cat');
		
		$findParams->criteria($findCriteria);
		
		$fieldRecord = Field::model()->find($findParams);
		if (!empty($fieldRecord))
			return $fieldRecord->id;
		else
			return false;
	}
	
	// Call an afterParentSave function on the Customfield type, so code can be
	// executed after save. (Example usage in GO\Sonycustomhistory\Customfieldtype\Customhistory)
	public function save($ignoreAcl=false){
		
		foreach($this->columns as $col=>$data){
			
			if(isset($data['customfield'])){
				$field = $data['customfield'];
				$field->customfieldtype->afterParentSave($col, $this->_rawPostedAttributes, $this->getModifiedAttributes(), $this);
			}
		}		
		return parent::save($ignoreAcl);
	}
	
	
//	public function save($ignoreAcl=false) {
//		
//		try {
//			return parent::save($ignoreAcl);
//		} catch (PDOException $e) {
//			$msg = $e->getMessage();
//
//			if (strpos($msg,'SQLSTATE[23000]')!==false) {
//				
//				preg_match('/col_(\d+)_unique/', $msg, $cfMatches);
//				
//				if (count($cfMatches)>1) {
//					$cField = Field::model()->findByPk($cfMatches[1]);
//					$cFieldPath = $cField->category->name.':'.$cField->name;
//					$feedbackString = str_replace('%cf',$cFieldPath,\GO::t('duplicateExistsFeedback','customfields'));
//					throw new \Exception($feedbackString);
//				} else {
//					throw $e;
//				}
//				
//			} else {
//				throw $e;
//			}
//		}
//		
//	}
}
