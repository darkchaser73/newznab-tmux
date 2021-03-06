<?php

namespace App\Models;

use Illuminate\Support\Carbon;
use Illuminate\Database\Eloquent\Model;

class UserSerie extends Model
{
    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @var bool
     */
    protected $dateFormat = false;

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'users_id');
    }

    /**
     * When a user wants to add a show to "my shows" insert it into the user series table.
     *
     *
     * @param $userId
     * @param $videoId
     * @param array $catID
     * @return int
     */
    public static function addShow($userId, $videoId, array $catID = []): int
    {
        return self::query()
            ->insertGetId(
                [
                    'users_id' => $userId,
                    'videos_id' => $videoId,
                    'categories' => ! empty($catID) ? implode('|', $catID) : 'NULL',
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ]
            );
    }

    /**
     * Get all the user's "my shows".
     *
     *
     * @param $userId
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public static function getShows($userId)
    {
        return self::query()
            ->where('user_series.users_id', $userId)
            ->select(['user_series.*', 'v.title'])
            ->join('videos as v', 'v.id', '=', 'user_series.videos_id')
            ->orderBy('v.title')
            ->get();
    }

    /**
     * Delete a tv show from the user's "my shows".
     *
     * @param int $userId    ID of user.
     * @param int $videoId ID of tv show.
     */
    public static function delShow($userId, $videoId): void
    {
        self::query()->where(['users_id' => $userId, 'videos_id' => $videoId])->delete();
    }

    /**
     * Get tv show information for a user.
     *
     *
     * @param $userId
     * @param $videoId
     * @return \Illuminate\Database\Eloquent\Model|null|static
     */
    public static function getShow($userId, $videoId)
    {
        return self::query()
            ->where(['user_series.users_id' => $userId, 'user_series.videos_id' => $videoId])
            ->select(['user_series.*', 'v.title'])
            ->leftJoin('videos as v', 'v.id', '=', 'user_series.videos_id')->first();
    }

    /**
     * Delete all shows from the user's "my shows".
     *
     *
     * @param $userId
     */
    public static function delShowForUser($userId): void
    {
        self::query()->where('users_id', $userId)->delete();
    }

    /**
     * Delete TV shows from all user's "my shows" that match a TV id.
     *
     *
     * @param $videoId
     */
    public static function delShowForSeries($videoId): void
    {
        self::query()->where('videos_id', $videoId)->delete();
    }

    /**
     * Update a TV show category ID for a user's "my show" TV show.
     *
     * @param int   $userId    ID of the user.
     * @param int $videoId ID of the TV show.
     * @param array $catID  List of category ID's.
     */
    public static function updateShow($userId, $videoId, array $catID = []): void
    {
        self::query()->where(['users_id' => $userId, 'videos_id' => $videoId])->update(['categories' =>  ! empty($catID) ? implode('|', $catID) : 'NULL']);
    }
}
