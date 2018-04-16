<?php

namespace App\Http\Controllers;

use App\Models\Video;
use App\Models\Category;
use App\Models\Settings;
use Blacklight\Releases;
use App\Models\UserSerie;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class MyShowsController extends BasePageController
{
    /**
     * @param \Illuminate\Http\Request $request
     *
     * @throws \Exception
     */
    public function show(Request $request)
    {
        $this->setPrefs();
        $action = $request->input('id') ?? '';
        $videoId = $request->input('subpage') ?? '';

        if ($request->has('from')) {
            $this->smarty->assign('from', WWW_TOP.$request->input('from'));
        } else {
            $this->smarty->assign('from', WWW_TOP.'/myshows');
        }

        switch ($action) {
            case 'delete':
                $show = UserSerie::getShow(Auth::id(), $videoId);
                if ($request->has('from')) {
                    header('Location:'.WWW_TOP.$request->input('from'));
                } else {
                    return redirect('myshows');
                }
                if (! $show) {
                    $this->show404();
                } else {
                    UserSerie::delShow(Auth::id(), $videoId);
                }

                break;
            case 'add':
            case 'doadd':
                $show = UserSerie::getShow(Auth::id(), $videoId);
                if ($show) {
                    $this->show404('Already subscribed');
                } else {
                    $show = Video::getByVideoID($videoId);
                    if (! $show) {
                        $this->show404('No matching show.');
                    }
                }

                if ($action === 'doadd') {
                    $category = ($request->has('category') && is_array($request->input('category')) && ! empty($request->input('category'))) ? $request->input('category') : [];
                    UserSerie::addShow(Auth::id(), $videoId, $category);
                    if ($request->has('from')) {
                        header('Location:'.WWW_TOP.$request->input('from'));
                    } else {
                        return redirect('myshows');
                    }
                } else {
                    $tmpcats = Category::getChildren(Category::TV_ROOT);
                    $categories = [];
                    foreach ($tmpcats as $c) {
                        // If TV WEB-DL categorization is disabled, don't include it as an option
                        if ((int) $c['id'] === Category::TV_WEBDL && (int) Settings::settingValue('indexer.categorise.catwebdl') === 0) {
                            continue;
                        }
                        $categories[$c['id']] = $c['title'];
                    }
                    $this->smarty->assign('type', 'add');
                    $this->smarty->assign('cat_ids', array_keys($categories));
                    $this->smarty->assign('cat_names', $categories);
                    $this->smarty->assign('cat_selected', []);
                    $this->smarty->assign('video', $videoId);
                    $this->smarty->assign('show', $show);
                    $content = $this->smarty->fetch('myshows-add.tpl');
                    $this->smarty->assign([
                        'content' => $content,
                    ]);
                    $this->pagerender();
                }
                break;
            case 'edit':
            case 'doedit':
                $show = UserSerie::getShow(Auth::id(), $videoId);

                if (! $show) {
                    $this->show404();
                }

                if ($action === 'doedit') {
                    $category = ($request->has('category') && \is_array($request->input('category')) && ! empty($request->input('category'))) ? $request->input('category') : [];
                    UserSerie::updateShow(Auth::id(), $videoId, $category);
                    if ($request->has('from')) {
                        return redirect($request->input('from'));
                    }

                    return redirect('myshows');
                }

            $tmpcats = Category::getChildren(Category::TV_ROOT);
            $categories = [];
            foreach ($tmpcats as $c) {
                $categories[$c['id']] = $c['title'];
            }

            $this->smarty->assign('type', 'edit');
            $this->smarty->assign('cat_ids', array_keys($categories));
            $this->smarty->assign('cat_names', $categories);
            $this->smarty->assign('cat_selected', explode('|', $show['categories']));
            $this->smarty->assign('video', $videoId);
            $this->smarty->assign('show', $show);
            $content = $this->smarty->fetch('myshows-add.tpl');
            $this->smarty->assign([
                'content' => $content,
            ]);
            $this->pagerender();
            break;
            case 'browse':

                $title = 'Browse My Shows';
                $meta_title = 'My Shows';
                $meta_keywords = 'search,add,to,cart,nzb,description,details';
                $meta_description = 'Browse Your Shows';

                $shows = UserSerie::getShows(Auth::id());

                $releases = new Releases(['Settings' => $this->settings]);

                $ordering = $releases->getBrowseOrdering();
                $orderby = $request->has('ob') && \in_array($request->input('ob'), $ordering, false) ? $request->input('ob') : '';

                $results = $releases->getShowsRange($shows, $orderby, -1, $this->userdata['categoryexclusions']);

                $this->smarty->assign('covgroup', '');

                foreach ($ordering as $ordertype) {
                    $this->smarty->assign('orderby'.$ordertype, WWW_TOP.'/myshows/browse?ob='.$ordertype.'&amp;offset=0');
                }

                $this->smarty->assign('lastvisit', $this->userdata['lastlogin']);

                $this->smarty->assign('results', $results);

                $this->smarty->assign('shows', true);

                $content = $this->smarty->fetch('browse.tpl');
                $this->smarty->assign([
                    'content' => $content,
                    'title' => $title,
                    'meta_title' => $meta_title,
                    'meta_keywords' => $meta_keywords,
                    'meta_description' => $meta_description,
                ]);
                $this->pagerender();
                break;
            default:

                $title = 'My Shows';
                $meta_title = 'My Shows';
                $meta_keywords = 'search,add,to,cart,nzb,description,details';
                $meta_description = 'Manage Your Shows';

                $tmpcats = Category::getChildren(Category::TV_ROOT);
                $categories = [];
                foreach ($tmpcats as $c) {
                    $categories[$c['id']] = $c['title'];
                }

                $shows = UserSerie::getShows(Auth::id());
                $results = [];
                foreach ($shows as $showk => $show) {
                    $showcats = explode('|', $show['categories']);
                    if (\is_array($showcats) && \count($showcats) > 0) {
                        $catarr = [];
                        foreach ($showcats as $scat) {
                            if (! empty($scat)) {
                                $catarr[] = $categories[$scat];
                            }
                        }
                        $show['categoryNames'] = implode(', ', $catarr);
                    } else {
                        $show['categoryNames'] = '';
                    }

                    $results[$showk] = $show;
                }
                $this->smarty->assign('shows', $results);

                $content = $this->smarty->fetch('myshows.tpl');
                $this->smarty->assign([
                    'content' => $content,
                    'title' => $title,
                    'meta_title' => $meta_title,
                    'meta_keywords' => $meta_keywords,
                    'meta_description' => $meta_description,
                ]);
                $this->pagerender();
                break;
        }
    }
}