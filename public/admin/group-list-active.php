<?php

require_once dirname(__DIR__).DIRECTORY_SEPARATOR.'smarty.php';

use App\Models\Group;
use Blacklight\http\AdminPage;

$page = new AdminPage();

$gname = '';
if (! empty(request()->input('groupname'))) {
    $gname = request()->input('groupname');
}

$groupcount = Group::getGroupsCount($gname, 1);

$offset = request()->input('offset') ?? 0;
$groupname = ! empty(request()->input('groupname')) ? request()->input('groupname') : '';

$page->smarty->assign('groupname', $groupname);
$page->smarty->assign('pagertotalitems', $groupcount);
$page->smarty->assign('pageroffset', $offset);
$page->smarty->assign('pageritemsperpage', config('nntmux.items_per_page'));
$page->smarty->assign('pagerquerysuffix', '#results');

$groupsearch = $gname !== '' ? 'groupname='.$gname.'&amp;' : '';
$page->smarty->assign('pagerquerybase', WWW_TOP.'/group-list-active.php?'.$groupsearch.'offset=');
$pager = $page->smarty->fetch('pager.tpl');
$page->smarty->assign('pager', $pager);

$grouplist = Group::getGroupsRange($offset, config('nntmux.items_per_page'), $gname, true);

$page->smarty->assign('grouplist', $grouplist);

$page->title = 'Group List';

$page->content = $page->smarty->fetch('group-list.tpl');
$page->render();
