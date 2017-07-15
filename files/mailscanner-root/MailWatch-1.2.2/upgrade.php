#!/usr/bin/php -q
<?php

/*
 * MailWatch for MailScanner
 * Copyright (C) 2003-2011  Steve Freegard (steve@freegard.name)
 * Copyright (C) 2011  Garrod Alwood (garrod.alwood@lorodoes.com)
 * Copyright (C) 2014-2017  MailWatch Team (https://github.com/mailwatch/1.2.0/graphs/contributors)
 *
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * In addition, as a special exception, the copyright holder gives permission to link the code of this program with
 * those files in the PEAR library that are licensed under the PHP License (or with modified versions of those files
 * that use the same license as those files), and distribute linked combinations including the two.
 * You must obey the GNU General Public License in all respects for all of the code used other than those files in the
 * PEAR library that are licensed under the PHP License. If you modify this program, you may extend this exception to
 * your version of the program, but you are not obligated to do so.
 * If you do not wish to do so, delete this exception statement from your version.
 *
 * As a special exception, you have permission to link this program with the JpGraph library and distribute executables,
 * as long as you follow the requirements of the GNU GPL in regard to all of the software in the executable aside from
 * JpGraph.
 *
 * You should have received a copy of the GNU General Public License along with this program; if not, write to the Free
 * Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

if (PHP_SAPI !== 'cli') {
    header('Content-type: text/plain');
}

// Edit if you changed webapp directory from default and not using command line argument to define it
$pathToFunctions = '/var/www/html/mailscanner/functions.php';
//$pathToFunctions = __DIR__ . '/mailscanner/functions.php';

$cli_options = getopt('', array('skip-user-confirm'));

if (isset($argv) && count($argv) > 1) {
    if (empty($cli_options)) {
        $pathToFunctions = $argv[1];
    } else {
        $args = array_search('--', $argv, true);
        $args = array_splice($argv, $args ? ++$args : (count($argv) - count($cli_options)));
        //get path from command line argument if set
        $pathToFunctions = $args[0];
    }
}

if (!@is_file($pathToFunctions)) {
    die('Error: Cannot find functions.php file in "' . $pathToFunctions . '": edit ' . __FILE__ . ' and set the right path on line ' . (__LINE__ - 3) . PHP_EOL);
}

require_once $pathToFunctions;

$link = dbconn();

$mysql_utf8_variant = array(
    'utf8' => array('charset' => 'utf8', 'collation' => 'utf8_unicode_ci'),
    'utf8mb4' => array('charset' => 'utf8mb4', 'collation' => 'utf8mb4_unicode_ci')
);

/**
 * @param string $input
 * @return string
 */
function pad($input)
{
    return str_pad($input, 70, '.', STR_PAD_RIGHT);
}

/**
 * @param string $sql
 */
function executeQuery($sql, $beSilent = false)
{
    global $link;
    if ($link->query($sql)) {
        if (!$beSilent) {
            echo color(' OK', 'green') . PHP_EOL;
        }
    } else {
        echo color(' ERROR', 'red') . PHP_EOL;
        die('Database error: ' . $link->error . " - SQL = '$sql'" . PHP_EOL);
    }
}

/**
 * @param string $table
 * @return bool|mysqli_result
 */
function check_table_exists($table)
{
    global $link;
    $sql = 'SHOW TABLES LIKE "' . $table . '"';

    return ($link->query($sql)->num_rows > 0);
}

/**
 * @param string $table
 * @param string $column
 * @return bool|mysqli_result
 */
function check_column_exists($table, $column)
{
    global $link;
    $sql = 'SHOW COLUMNS FROM `' . $table . '` LIKE "' . $column . '"';

    return ($link->query($sql)->num_rows > 0);
}

/**
 * @return string|bool
 */
function get_database_charset()
{
    global $link;
    $sql = 'SELECT default_character_set_name
            FROM information_schema.schemata
            WHERE schema_name = "' . DB_NAME . '"';
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    $result = $link->query($sql);
    $row = $result->fetch_array();
    if (null !== $row && isset($row[0])) {
        return $row[0];
    }

    return false;
}

/**
 * @return string|bool
 */
function get_database_collation()
{
    global $link;
    $sql = 'SELECT default_collation_name
            FROM information_schema.schemata
            WHERE schema_name = "' . DB_NAME . '"';
    $result = $link->query($sql);
    $row = $result->fetch_array();
    if (null !== $row && isset($row[0])) {
        return $row[0];
    }

    return false;
}

/**
 * @param string $db
 * @param string $table
 * @param string $utf8variant
 * @return bool
 */
function check_utf8_table($db, $table, $utf8variant = 'utf8')
{
    global $link;
    global $mysql_utf8_variant;

    $sql = 'SELECT c.character_set_name, c.collation_name
            FROM information_schema.tables AS t, information_schema.collation_character_set_applicability AS c
            WHERE c.collation_name = t.table_collation
            AND t.table_schema = "' . $link->real_escape_string($db) . '"
            AND t.table_name = "' . $link->real_escape_string($table) . '"';
    $result = $link->query($sql);

    $table_charset = database::mysqli_result($result, 0, 0);
    $table_collation = database::mysqli_result($result, 0, 1);

    return (
        strtolower($table_charset) === $mysql_utf8_variant[$utf8variant]['charset'] &&
        strtolower($table_collation) === $mysql_utf8_variant[$utf8variant]['collation']
    );
}

/**
 * @param string $db
 * @param string $table
 * @return bool
 */
function is_table_type_innodb($db, $table)
{
    global $link;
    $sql = 'SELECT t.engine 
            FROM information_schema.tables AS t 
            WHERE t.table_schema = "' . $link->real_escape_string($db) . '" 
            AND t.table_name = "' . $link->real_escape_string($table) . '"';
    $result = $link->query($sql);

    return 'innodb' === strtolower(database::mysqli_result($result, 0, 0));
}

/**
 * @param string $db
 * @param string $table
 * @param string $index
 * @return int|null
 */
function get_index_size($db, $table, $index)
{
    global $link;
    $sql = 'SHOW INDEX FROM ' . $db . '.' . $table . ' WHERE Key_name = "' . $index . '"';
    $result = $link->query($sql);
    $row = $result->fetch_assoc();
    if (null === $row || null === $row['Sub_part']) {
        return null;
    }

    return (int)$row['Sub_part'];
}

/**
 * @param string $table
 * @return array
 */
function getTableIndexes($table)
{
    global $link;
    $sql = 'SHOW INDEX FROM `' . $table . '`';
    $result = $link->query($sql);

    $indexes = array();
    if (false === $result || $result->num_rows === 0) {
        return $indexes;
    }

    while ($row = $result->fetch_assoc()) {
        $indexes[] = $row['Key_name'];
    }

    return $indexes;
}

/**
 * @param string $string
 * @param string $color
 * @return string
 */
function color($string, $color = '')
{
    $after = "\033[0m";
    switch ($color) {
        case 'green':
            $before = "\033[1;32m";
            break;
        case 'lightgreen':
            $before = "\033[0;32m";
            break;
        case 'yellow':
            $before = "\033[1;33;40m";
            break;
        case 'red':
            $before = "\033[0;31m";
            break;
        default:
            $before = '';
            $after = '';
            break;
    }

    return $before . $string . $after;
}

$errors = false;

// Upgrade mailwatch database
echo PHP_EOL;
echo 'MailWatch for MailScanner Database Upgrade to ' . mailwatch_version() . PHP_EOL;
echo PHP_EOL;

if (!array_key_exists('skip-user-confirm', $cli_options)) {
    echo "Have you done a full backup of your database? Type 'yes' to continue: ";
    $handle = fopen('php://stdin', 'rb');
    $line = fgets($handle);
    if (strtolower(trim($line)) !== 'yes') {
        echo 'ABORTING!' . PHP_EOL;
        exit(1);
    }
    fclose($handle);

    echo PHP_EOL;
}

// Test connectivity to the database
echo pad('Testing connectivity to the database ');

if ($link) {
    echo color(' OK', 'green') . PHP_EOL;
    // Update schema at this point
    echo PHP_EOL;
    echo 'Updating database schema: ' . PHP_EOL;
    echo PHP_EOL;

    /*
    ** Updates to the schema for 1.2.0
    */

    $server_utf8_variant = 'utf8';

    // Convert database to utf8 if not already utf8mb4 or if other charset
    echo pad(' - Convert database to ' . $server_utf8_variant . '');
    if (get_database_charset() === $mysql_utf8_variant['utf8mb4']['charset'] && get_database_collation() === $mysql_utf8_variant['utf8mb4']['collation']) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $server_utf8_variant = 'utf8';
        $sql = 'ALTER DATABASE `' . DB_NAME .
            '` CHARACTER SET = ' . $mysql_utf8_variant[$server_utf8_variant]['charset'] .
            ' COLLATE = ' . $mysql_utf8_variant[$server_utf8_variant]['collation'];
        executeQuery($sql);
    }

    echo PHP_EOL;

    // Drop geoip table
    echo pad(' - Drop `geoip_country` table');
    if (false === check_table_exists('geoip_country')) {
        echo color(' ALREADY DROPPED', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'DROP TABLE IF EXISTS `geoip_country`';
        executeQuery($sql);
    }

    // Drop spamscores table
    echo pad(' - Drop `spamscores` table');
    if (false === check_table_exists('spamscores')) {
        echo color(' ALREADY DROPPED', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'DROP TABLE IF EXISTS `spamscores`';
        executeQuery($sql);
    }

    // Add autorelease table if not exist (1.2RC2)
    echo pad(' - Add autorelease table to `' . DB_NAME . '` database');
    if (true === check_table_exists('autorelease')) {
        echo color(' ALREADY EXIST', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'CREATE TABLE IF NOT EXISTS `autorelease` (
            `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
            `msg_id` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
            `uid` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
            PRIMARY KEY (`id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci';
        executeQuery($sql);
    }

    // Update users table schema for password-reset feature
    echo pad(' - Add resetid, resetexpire and lastreset fields in `users` table');
    if (check_column_exists('users', 'resetid') === false) {
        $sql = 'ALTER TABLE `users` ADD COLUMN (
            `resetid` VARCHAR(32),
            `resetexpire` BIGINT(20),
            `lastreset` BIGINT(20)
            );';
        executeQuery($sql);
    } else {
        echo color(' ALREADY EXIST', 'lightgreen') . PHP_EOL;
    }

    echo PHP_EOL;

    // Truncate needed for VARCHAR fields used as PRIMARY or FOREIGN KEY when using utf8mb4

    // Table audit_log
    echo pad(' - Fix schema for username field in `audit_log` table');
    $sql = "ALTER TABLE `audit_log` CHANGE `user` `user` VARCHAR( 191 ) NOT NULL DEFAULT ''";
    executeQuery($sql);

    // Table blacklist
    echo pad(' - Fix schema for id field in `blacklist` table');
    $sql = 'ALTER TABLE `blacklist` CHANGE `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT';
    executeQuery($sql);

    // Table users
    echo pad(' - Fix schema for username field in `users` table');
    $sql = "ALTER TABLE `users` CHANGE `username` `username` VARCHAR( 191 ) NOT NULL DEFAULT ''";
    executeQuery($sql);

    echo pad(' - Fix schema for spamscore field in `users` table');
    $sql = "ALTER TABLE `users` CHANGE `spamscore` `spamscore` FLOAT DEFAULT '0'";
    executeQuery($sql);

    echo pad(' - Fix schema for highspamscore field in `users` table');
    $sql = "ALTER TABLE `users` CHANGE `highspamscore` `highspamscore` FLOAT DEFAULT '0'";
    executeQuery($sql);

    // Table user_filters
    echo pad(' - Fix schema for username field in `user_filters` table');
    $sql = "ALTER TABLE `user_filters` CHANGE `username` `username` VARCHAR( 191 ) NOT NULL DEFAULT ''";
    executeQuery($sql);

    // Table whitelist
    echo pad(' - Fix schema for username field in `whitelist` table');
    $sql = 'ALTER TABLE `whitelist` CHANGE `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT';
    executeQuery($sql);

    // Revert back some tables to the right values due to previous errors in upgrade.php

    // Table audit_log
    echo pad(' - Fix schema for username field in `audit_log` table');
    $sql = "ALTER TABLE `audit_log` CHANGE `user` `user` VARCHAR( 255 ) NOT NULL DEFAULT ''";
    executeQuery($sql);

    // Table users
    echo pad(' - Fix schema for password field in `users` table');
    $sql = 'ALTER TABLE `users` CHANGE `password` `password` VARCHAR( 255 ) DEFAULT NULL';
    executeQuery($sql);

    echo pad(' - Fix schema for fullname field in `users` table');
    $sql = "ALTER TABLE `users` CHANGE `fullname` `fullname` VARCHAR( 255 ) NOT NULL DEFAULT ''";
    executeQuery($sql);

    // Table mcp_rules
    echo pad(' - Fix schema for rule_desc field in `mcp_rules` table');
    $sql = "ALTER TABLE `mcp_rules` CHANGE `rule_desc` `rule_desc` VARCHAR( 200 ) NOT NULL DEFAULT ''";
    executeQuery($sql);

    echo PHP_EOL;
    
    // Cleanup orphaned user_filters
    echo pad(' - Cleanup orphaned user_filters');
    $sql = 'DELETE FROM `user_filters` WHERE `username` NOT IN (SELECT `username` FROM `users`)';
    executeQuery($sql);

    // Add new column and index to audit_log table
    echo pad(' - Add id field and primary key to `audit_log` table');
    if (true === check_column_exists('audit_log', 'id')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `audit_log` ADD `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`)';
        executeQuery($sql);
    }

    // Add new column and index to inq table
    echo pad(' - Add inq_id field and primary key to `inq` table');
    if (true === check_column_exists('inq', 'inq_id')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `inq` ADD `inq_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`inq_id`)';
        executeQuery($sql);
    }

    // Add new column and index to maillog table
    echo pad(' - Add maillog_id field and primary key to `maillog` table');
    if (true === check_column_exists('maillog', 'maillog_id')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `maillog` ADD `maillog_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`maillog_id`)';
        executeQuery($sql);
    }

    // Add new column to maillog table
    echo pad(' - Add rblspamreport field to `maillog` table');
    if (true === check_column_exists('maillog', 'rblspamreport')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `maillog` ADD `rblspamreport` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL';
        executeQuery($sql);
    }
    
    // Add new token column to maillog table
    echo pad(' - Add token field to `maillog` table');
    if (true === check_column_exists('maillog', 'token')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `maillog` ADD `token` CHAR(64) COLLATE utf8_unicode_ci DEFAULT NULL';
        executeQuery($sql);
    }
    
    // Check for missing tokens in maillog table and add them back QUARANTINE_REPORT_DAYS
    echo pad(' - Check for missing tokens in `maillog` table');
    if (defined('QUARANTINE_REPORT_DAYS')) {
        $report_days=QUARANTINE_REPORT_DAYS;
    } else {
        // Missing, but let's keep going...
        $report_days=7;
    }
    $sql = 'SELECT `id`,`token` FROM `maillog` WHERE `date` >= DATE_SUB(CURRENT_DATE(), INTERVAL ' . $report_days . ' DAY)';
    $result = dbquery($sql);
    $rows = $result->num_rows;
    $countTokenGenerated = 0;
    if ($rows > 0) {
        while ($row = $result->fetch_object()) {
            if ($row->token === null) {
                $sql = 'UPDATE `maillog` SET `token`=\'' . generateToken() . '\' WHERE `id`=\'' . trim($row->id) . '\'';
                executeQuery($sql, true);
                $countTokenGenerated++;
            }
        }
    }
    echo color(' DONE', 'lightgreen') . PHP_EOL;
    echo '   ' . $countTokenGenerated . ' token generated' . PHP_EOL;

    // Add new column and index to mtalog table
    echo pad(' - Add mtalog_id field and primary key to `mtalog` table');
    if (true === check_column_exists('mtalog', 'mtalog_id')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `mtalog` ADD `mtalog_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`mtalog_id`)';
        executeQuery($sql);
    }

    // Add new column and index to outq table
    echo pad(' - Add mtalog_id field and primary key to `outq` table');
    if (true === check_column_exists('outq', 'outq_id')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `outq` ADD `outq_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`outq_id`)';
        executeQuery($sql);
    }

    // Add new column and index to saved_filters table
    echo pad(' - Add id field and primary key to `saved_filters` table');
    if (true === check_column_exists('saved_filters', 'id')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `saved_filters` ADD `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`)';
        executeQuery($sql);
    }

    // Add new column and index to user_filters table
    echo pad(' - Add mtalog_id field and primary key to `user_filters` table');
    if (true === check_column_exists('user_filters', 'id')) {
        echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
    } else {
        $sql = 'ALTER TABLE `user_filters` ADD `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`)';
        executeQuery($sql);
    }

    echo PHP_EOL;

    // Fix existing index size for utf8mb4 conversion
    $too_big_indexes = array(
        'maillog_from_idx',
        'maillog_to_idx',
    );

    foreach ($too_big_indexes as $item) {
        echo pad(' - Dropping too big index `' . $item . '` on table `maillog`');
        if (get_index_size(DB_NAME, 'maillog', $item) > 191) {
            $sql = 'ALTER TABLE `maillog` DROP INDEX `' . $item . '`';
            executeQuery($sql);
        } else {
            echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
        }
    }

    echo PHP_EOL;

    // Convert database to utf8mb4 if MySQL ≥ 5.5.3
    if ($link->server_version >= 50503) {
        $server_utf8_variant = 'utf8mb4';
        echo pad(' - Convert database to ' . $server_utf8_variant . '');
        if (get_database_charset() === $mysql_utf8_variant[$server_utf8_variant]['charset'] && get_database_collation() === $mysql_utf8_variant[$server_utf8_variant]['collation']) {
            echo color(' ALREADY DONE', 'lightgreen') . PHP_EOL;
        } else {
            $sql = 'ALTER DATABASE `' . DB_NAME .
                '` CHARACTER SET = ' . $mysql_utf8_variant[$server_utf8_variant]['charset'] .
                ' COLLATE = ' . $mysql_utf8_variant[$server_utf8_variant]['collation'];
            executeQuery($sql);
        }
    }

    echo PHP_EOL;

    $utf8_tables = array(
        'audit_log',
        'autorelease',
        'blacklist',
        'inq',
        'maillog',
        'mcp_rules',
        'mtalog',
        'mtalog_ids',
        'outq',
        'saved_filters',
        'sa_rules',
        'users',
        'user_filters',
        'whitelist',
    );

    // Convert tables to utf8 using $utf8_tables array
    foreach ($utf8_tables as $table) {
        echo pad(' - Convert table `' . $table . '` to ' . $server_utf8_variant . '');
        if (false === check_table_exists($table)) {
            echo ' DO NOT EXISTS' . PHP_EOL;
        } else {
            if (check_utf8_table(DB_NAME, $table, $server_utf8_variant) === false) {
                $sql = 'ALTER TABLE `' . $table .
                    '` CONVERT TO CHARACTER SET ' . $mysql_utf8_variant[$server_utf8_variant]['charset'] .
                    ' COLLATE ' . $mysql_utf8_variant[$server_utf8_variant]['collation'];
                executeQuery($sql);
            } else {
                echo color(' ALREADY CONVERTED', 'lightgreen') . PHP_EOL;
            }
        }
    }

    echo PHP_EOL;

    // Convert tables to InnoDB using $utf8_tables array
    foreach ($utf8_tables as $table) {
        echo pad(' - Convert table `' . $table . '` to InnoDB');
        if (false === check_table_exists($table)) {
            echo ' DO NOT EXISTS' . PHP_EOL;
        } else {
            if (is_table_type_innodb(DB_NAME, $table) === false) {
                $sql = 'ALTER TABLE `' . $table . '` ENGINE = InnoDB';
                executeQuery($sql);
            } else {
                echo color(' ALREADY CONVERTED', 'lightgreen') . PHP_EOL;
            }
        }
    }

    // check for missing indexes
    $indexes = array(
        'maillog' => array(
            'maillog_datetime_idx' => array('fields' => '(`date`,`time`)', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'maillog_id_idx' => array('fields' => '(`id`(20))', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'maillog_clientip_idx' => array('fields' => '(`clientip`(20))', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'maillog_from_idx' => array('fields' => '(`from_address`(191))', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'maillog_to_idx' => array('fields' => '(`to_address`(191))', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'maillog_host' => array('fields' => '(`hostname`(30))', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'from_domain_idx' => array('fields' => '(`from_domain`(50))', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'to_domain_idx' => array('fields' => '(`to_domain`(50))', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'maillog_quarantined' => array('fields' => '(`quarantined`)', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            'timestamp_idx' => array('fields' => '(`timestamp`)', 'type' => 'KEY', 'minMysqlVersion' => '50100'),
            // can't use FULLTEXT index on InnoDB table in MySQL < 5.6.4
            'subject_idx' => array('fields' => '(`subject`)', 'type' => 'FULLTEXT', 'minMysqlVersion' => '50604'),
        )
    );

    foreach ($indexes as $table => $indexlist) {
        echo PHP_EOL . pad(' - Search for missing indexes on table `' . $table . '`') . color(' DONE', 'green') . PHP_EOL;
        $existingIndexes = getTableIndexes($table);
        foreach ($indexlist as $indexname => $indexValue) {
            if (!in_array($indexname, $existingIndexes, true)) {
                echo pad(' - Adding missing index `' . $indexname . '` on table `' . $table . '`');
                if ($link->server_version >= $indexValue['minMysqlVersion']) {
                    $sql = 'ALTER TABLE `' . $table .
                        '` ADD ' . $indexValue['type'] . ' `' . $indexname . '` ' .
                        $indexValue['fields'] .
                        ';';
                    executeQuery($sql);
                } else {
                    echo ' ' . color('WARNING', 'yellow') . PHP_EOL;
                    $errors[] = 'Table Index: MySQL version unsupported for index `' . $indexname . '` on table `' . $table . '`, ' .
                        'upgrade to version >= ' . $indexValue['minMysqlVersion'] . ' (you have version ' . $link->server_version . ')';
                }
            }
        }
    }
    dbclose();
} else {
    echo color(' FAILED', 'red') . PHP_EOL;
    $errors[] = 'Database connection failed: ' . $link->error;
}

echo PHP_EOL;

// Check MailScanner settings
echo 'Checking MailScanner.conf settings: ' . PHP_EOL;
echo PHP_EOL;
$check_settings = array(
    'QuarantineWholeMessage' => 'yes',
    'QuarantineWholeMessagesAsQueueFiles' => 'no',
    'DetailedSpamReport' => 'yes',
    'IncludeScoresInSpamAssassinReport' => 'yes',
    'SpamActions' => 'store',
    'HighScoringSpamActions' => 'store',
    'AlwaysLookedUpLast' => '&MailWatchLogging'
);

foreach ($check_settings as $setting => $value) {
    echo pad(" - $setting ");
    if (preg_match('/' . $value . '/', get_conf_var($setting))) {
        echo color(' OK', 'green') . PHP_EOL;
    } else {
        echo ' ' . color('WARNING', 'yellow') . PHP_EOL;
        $errors[] = "MailScanner.conf: $setting != $value (=" . get_conf_var($setting) . ')';
    }
}

echo PHP_EOL;

// Check configuration for missing entries
echo 'Checking conf.php configuration entry: ' . PHP_EOL;
echo PHP_EOL;
$checkConfigEntries = checkConfVariables();
if ($checkConfigEntries['needed']['count'] === 0) {
    echo pad(' - All mandatory entries are present') . color(' OK', 'green') . PHP_EOL;
} else {
    foreach ($checkConfigEntries['needed']['list'] as $missingConfigEntry) {
        echo pad(" - $missingConfigEntry ") . ' ' . color('WARNING', 'yellow') . PHP_EOL;
        $errors[] = 'conf.php: missing configuration entry "' . $missingConfigEntry . '"';
    }
}

if ($checkConfigEntries['obsolete']['count'] === 0) {
    echo pad(' - All obsolete entries are already removed') . color(' OK', 'green') . PHP_EOL;
} else {
    foreach ($checkConfigEntries['obsolete']['list'] as $obsoleteConfigEntry) {
        echo pad(" - $obsoleteConfigEntry ") . ' ' . color('WARNING', 'yellow') . PHP_EOL;
        $errors[] = 'conf.php: obsolete configuration entry "' . $obsoleteConfigEntry . '" still present';
    }
}

if ($checkConfigEntries['optional']['count'] === 0) {
    echo pad(' - All optional entries are already present') . color(' OK', 'green') . PHP_EOL;
} else {
    foreach ($checkConfigEntries['optional']['list'] as $optionalConfigEntry => $detail) {
        echo pad(" - optional $optionalConfigEntry ") . ' ' . color('WARNING', 'yellow') . PHP_EOL;
        $errors[] = 'conf.php: optional configuration entry "' . $optionalConfigEntry . '" is missing, ' . $detail['description'];
    }
}

echo PHP_EOL;

// Error messages
if (is_array($errors)) {
    echo '*** ERROR/WARNING SUMMARY ***' . PHP_EOL;
    foreach ($errors as $error) {
        echo $error . PHP_EOL;
    }
    echo PHP_EOL;
}