<?php
/**
 * @copyright Copyright (c) 2017 Joas Schilling <coding@schilljs.com>
 *
 * @license GNU AGPL version 3 or any later version
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

namespace OCA\External\Controller;

use OCA\External\SitesManager;
use OCP\AppFramework\Controller;
use OCP\AppFramework\Http\TemplateResponse;
use OCP\IRequest;
use OCP\IURLGenerator;

class SettingsController extends Controller {
	/** @var SitesManager */
	protected $sitesManager;
	/** @var IURLGenerator */
	protected $url;

	/**
	 * constructor of the controller
	 *
	 * @param string $appName
	 * @param IRequest $request
	 * @param SitesManager $sitesManager
	 * @param IURLGenerator $url
	 */
	public function __construct($appName,
								IRequest $request,
								SitesManager $sitesManager,
								IURLGenerator $url) {
		parent::__construct($appName, $request);
		$this->sitesManager = $sitesManager;
		$this->url = $url;
	}

	/**
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 *
	 * @return TemplateResponse
	 */
	public function displayPanel() {
		$pages = $this->sitesManager->getSitesToDisplay();

		$quotaLink = [];
		foreach ($pages as $page) {
			if ($page['type'] === SitesManager::TYPE_QUOTA) {
				$quotaLink = $page;
				break;
			}
		}

		return new TemplateResponse('external', 'quota', [
			'quotaLink'			=> $this->url->linkToRoute('external.page.showPage', ['id'=> $quotaLink['id']]),
			'quotaName'			=> $quotaLink['name'],
		], '');
	}
}
