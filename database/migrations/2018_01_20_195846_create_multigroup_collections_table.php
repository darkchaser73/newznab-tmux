<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateMultigroupCollectionsTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('multigroup_collections', function(Blueprint $table)
		{
			$table->increments('id');
			$table->string('subject')->default('');
			$table->string('fromname')->default('')->index('fromname');
			$table->dateTime('date')->nullable()->index('date');
			$table->string('xref', 2000)->default('');
			$table->integer('totalfiles')->unsigned()->default(0);
			$table->integer('groups_id')->unsigned()->default(0)->index('groups_id');
			$table->string('collectionhash')->default('0')->unique('ix_collection_collectionhash');
			$table->integer('collection_regexes_id')->default(0)->comment('FK to collection_regexes.id');
			$table->dateTime('dateadded')->nullable()->index('ix_collection_dateadded');
			$table->timestamp('added')->useCurrent();
			$table->boolean('filecheck')->default(0)->index('ix_collection_filecheck');
			$table->bigInteger('filesize')->unsigned()->default(0);
			$table->integer('releases_id')->nullable()->index('ix_collection_releaseid');
			$table->char('noise', 32)->default('');
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('multigroup_collections');
	}

}
