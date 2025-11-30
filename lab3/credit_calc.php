<?php
require_once dirname(__FILE__).'/config.php';
require_once getConf()->root_path.'/lib/smarty/Smarty.class.php';
require_once getConf()->root_path.'/app/controllers/CalcCtrl.class.php';

$smarty = new Smarty();
$smarty->setTemplateDir(getConf()->root_path.'/templates');
$smarty->setCompileDir(getConf()->root_path.'/templates_c');
$smarty->assign('conf', getConf());

$ctrl = new CalcCtrl();
$ctrl->process();
