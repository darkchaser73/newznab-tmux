<?php

require_once dirname(__DIR__, 2).DIRECTORY_SEPARATOR.'resources/views/themes/smarty.php';

use Blacklight\AniDB;

if (request()->has('id')) {
    $AniDB = new AniDB();
    $AniDB->deleteTitle(request()->input('id'));
}

$referrer = request()->server('HTTP_REFERER');
header('Location: '.$referrer);
