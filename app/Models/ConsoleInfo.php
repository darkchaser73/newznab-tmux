<?php

namespace App\Models;

use Laravel\Scout\Searchable;
use Illuminate\Database\Eloquent\Model;

class ConsoleInfo extends Model
{
    use Searchable;
    /**
     * @var string
     */
    protected $table = 'consoleinfo';

    /**
     * @var bool
     */
    protected $dateFormat = false;

    /**
     * @var array
     */
    protected $guarded = [];

    public function searchableAs()
    {
        return 'ix_consoleinfo_title_platform_ft';
    }

    /**
     * @return array
     */
    public function toSearchableArray()
    {
        return [
            'title'=> $this->title,
            'platform' => $this->platform,
        ];
    }
}
