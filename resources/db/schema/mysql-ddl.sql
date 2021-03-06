DROP TABLE IF EXISTS collections;
CREATE TABLE         collections (
  id             INT(11) UNSIGNED    NOT NULL AUTO_INCREMENT,
  subject        VARCHAR(255)        NOT NULL DEFAULT '',
  fromname       VARCHAR(255)        NOT NULL DEFAULT '',
  date           DATETIME            DEFAULT NULL,
  xref           VARCHAR(2000)        NOT NULL DEFAULT '',
  totalfiles     INT(11) UNSIGNED    NOT NULL DEFAULT '0',
  groups_id       INT(11) UNSIGNED    NOT NULL DEFAULT '0',
  collectionhash VARCHAR(255)        NOT NULL DEFAULT '0',
  collection_regexes_id INT SIGNED NOT NULL DEFAULT '0' COMMENT 'FK to collection_regexes.id',
  dateadded      DATETIME            DEFAULT NULL,
  added          TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
  filecheck      TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  filesize       BIGINT UNSIGNED     NOT NULL DEFAULT '0',
  releases_id      INT                 NULL,
  noise          CHAR(32)            NOT NULL DEFAULT '',
  PRIMARY KEY                               (id),
  INDEX        fromname                     (fromname),
  INDEX        date                         (date),
  INDEX        groups_id                     (groups_id),
  INDEX        ix_collection_filecheck      (filecheck),
  INDEX        ix_collection_dateadded      (dateadded),
  INDEX        ix_collection_releaseid      (releases_id),
  UNIQUE INDEX ix_collection_collectionhash (collectionhash)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS releases;
CREATE TABLE         releases (
  id                INT(11) UNSIGNED               NOT NULL AUTO_INCREMENT,
  name              VARCHAR(255)                   NOT NULL DEFAULT '',
  searchname        VARCHAR(255)                   NOT NULL DEFAULT '',
  totalpart         INT                            DEFAULT '0',
  groups_id         INT(11) UNSIGNED               NOT NULL DEFAULT '0' COMMENT 'FK to groups.id',
  size              BIGINT UNSIGNED                NOT NULL DEFAULT '0',
  postdate          DATETIME                       DEFAULT NULL,
  adddate           DATETIME                       DEFAULT NULL,
  updatetime        TIMESTAMP                      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  gid               VARCHAR(32)                    NULL,
  guid              VARCHAR(40)                    NOT NULL,
  leftguid          CHAR(1)                        NOT NULL COMMENT 'The first letter of the release guid',
  fromname          VARCHAR(255)                   NULL,
  completion        FLOAT                          NOT NULL DEFAULT '0',
  categories_id     INT                            NOT NULL DEFAULT '0010',
  videos_id         MEDIUMINT(11) UNSIGNED         NOT NULL DEFAULT '0' COMMENT 'FK to videos.id of the parent series.',
  tv_episodes_id    MEDIUMINT(11) SIGNED           NOT NULL DEFAULT '0' COMMENT 'FK to tv_episodes.id for the episode.',
  imdbid            MEDIUMINT(7) UNSIGNED ZEROFILL NULL,
  xxxinfo_id        INT SIGNED                     NOT NULL DEFAULT '0',
  musicinfo_id      INT(11) SIGNED               NULL COMMENT 'FK to musicinfo.id',
  consoleinfo_id    INT(11) SIGNED               NULL COMMENT 'FK to consoleinfo.id',
  gamesinfo_id      INT SIGNED                     NOT NULL DEFAULT '0',
  bookinfo_id       INT(11) SIGNED               NULL COMMENT 'FK to bookinfo.id',
  anidbid           INT                            NULL COMMENT 'FK to anidb_titles.anidbid',
  predb_id          INT(11) UNSIGNED               NOT NULL DEFAULT '0' COMMENT 'FK to predb.id',
  grabs             INT UNSIGNED                   NOT NULL DEFAULT '0',
  comments          INT                            NOT NULL DEFAULT '0',
  passwordstatus    TINYINT                        NOT NULL DEFAULT '0',
  rarinnerfilecount INT                            NOT NULL DEFAULT '0',
  haspreview        TINYINT                        NOT NULL DEFAULT '0',
  nfostatus         TINYINT                        NOT NULL DEFAULT '0',
  jpgstatus         TINYINT(1)                     NOT NULL DEFAULT '0',
  videostatus       TINYINT(1)                     NOT NULL DEFAULT '0',
  audiostatus       TINYINT(1)                     NOT NULL DEFAULT '0',
  dehashstatus      TINYINT(1)                     NOT NULL DEFAULT '0',
  reqidstatus       TINYINT(1)                     NOT NULL DEFAULT '0',
  nzb_guid          BINARY(16)                     NULL,
  nzbstatus         TINYINT(1)                     NOT NULL DEFAULT '0',
  iscategorized     TINYINT(1)                     NOT NULL DEFAULT '0',
  isrenamed         TINYINT(1)                     NOT NULL DEFAULT '0',
  ishashed          TINYINT(1)                     NOT NULL DEFAULT '0',
  proc_pp           TINYINT(1)                     NOT NULL DEFAULT '0',
  proc_sorter       TINYINT(1)                     NOT NULL DEFAULT '0',
  proc_par2         TINYINT(1)                     NOT NULL DEFAULT '0',
  proc_nfo          TINYINT(1)                     NOT NULL DEFAULT '0',
  proc_files        TINYINT(1)                     NOT NULL DEFAULT '0',
  proc_uid          TINYINT(1)                     NOT NULL DEFAULT '0',
  proc_srr          TINYINT(1)                     NOT NULL DEFAULT '0' COMMENT 'Has the release been srr
processed',
  proc_hash16k      TINYINT(1)                     NOT NULL DEFAULT '0' COMMENT 'Has the release been hash16k
processed',
  PRIMARY KEY                                 (id, categories_id),
  INDEX ix_releases_name                      (name),
  INDEX ix_releases_groupsid                  (groups_id,passwordstatus),
  INDEX ix_releases_postdate_searchname       (postdate,searchname),
  INDEX ix_releases_guid                      (guid),
  INDEX ix_releases_leftguid                  (leftguid ASC, predb_id),
  INDEX ix_releases_nzb_guid                  (nzb_guid),
  INDEX ix_releases_videos_id                 (videos_id),
  INDEX ix_releases_tv_episodes_id            (tv_episodes_id),
  INDEX ix_releases_imdbid                    (imdbid),
  INDEX ix_releases_xxxinfo_id                (xxxinfo_id),
  INDEX ix_releases_musicinfo_id              (musicinfo_id,passwordstatus),
  INDEX ix_releases_consoleinfo_id            (consoleinfo_id),
  INDEX ix_releases_gamesinfo_id              (gamesinfo_id),
  INDEX ix_releases_bookinfo_id               (bookinfo_id),
  INDEX ix_releases_anidbid                   (anidbid),
  INDEX ix_releases_predb_id_searchname       (predb_id,searchname),
  INDEX ix_releases_haspreview_passwordstatus (haspreview,passwordstatus),
  INDEX ix_releases_passwordstatus            (passwordstatus),
  INDEX ix_releases_nfostatus                 (nfostatus,size),
  INDEX ix_releases_dehashstatus              (dehashstatus,ishashed)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id             INT(16) UNSIGNED NOT NULL AUTO_INCREMENT,
  username       VARCHAR(50)      NOT NULL,
  firstname      VARCHAR(255)              DEFAULT NULL,
  lastname       VARCHAR(255)              DEFAULT NULL,
  email          VARCHAR(255)     NOT NULL,
  password       VARCHAR(255)     NOT NULL,
  user_roles_id  INT              NOT NULL DEFAULT '1' COMMENT 'FK to user_roles.id',
  host           VARCHAR(40)      NULL,
  grabs          INT              NOT NULL DEFAULT '0',
  rsstoken       VARCHAR(64)      NOT NULL,
  created_at    DATETIME         NOT NULL,
  updated_at    DATETIME         NOT NULL,
  resetguid      VARCHAR(50)      NULL,
  lastlogin      DATETIME                  DEFAULT NULL,
  apiaccess      DATETIME                  DEFAULT NULL,
  invites        INT              NOT NULL DEFAULT '0',
  invitedby      INT              NULL,
  movieview      INT              NOT NULL DEFAULT '1',
  xxxview        INT              NOT NULL DEFAULT '1',
  musicview      INT              NOT NULL DEFAULT '1',
  consoleview    INT              NOT NULL DEFAULT '1',
  bookview       INT              NOT NULL DEFAULT '1',
  gameview       INT              NOT NULL DEFAULT 1,
  saburl         VARCHAR(255)     NULL     DEFAULT NULL,
  sabapikey      VARCHAR(255)     NULL     DEFAULT NULL,
  sabapikeytype  TINYINT(1)       NULL     DEFAULT NULL,
  sabpriority    TINYINT(1)       NULL     DEFAULT NULL,
  queuetype      TINYINT(1)       NOT NULL DEFAULT '1' COMMENT 'Type of queue, Sab or NZBGet',
  nzbgeturl      VARCHAR(255)     NULL     DEFAULT NULL,
  nzbgetusername VARCHAR(255)     NULL     DEFAULT NULL,
  nzbgetpassword VARCHAR(255)     NULL     DEFAULT NULL,
  nzbvortex_api_key VARCHAR(10)   NULL     DEFAULT NULL ,
  nzbvortex_server_url VARCHAR(255) NULL   DEFAULT NULL,
  userseed       VARCHAR(50)      NOT NULL,
  notes          VARCHAR(255)     NOT NULL,
  cp_url         VARCHAR(255)     NULL     DEFAULT NULL,
  cp_api         VARCHAR(255)     NULL     DEFAULT NULL,
  style          VARCHAR(255)     NULL     DEFAULT NULL,
  rolechangedate DATETIME         NULL     DEFAULT NULL COMMENT 'When does the role expire',
  PRIMARY KEY (id),
  INDEX ix_user_roles (user_roles_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS anidb_episodes;
CREATE TABLE anidb_episodes (
  anidbid       INT(10) UNSIGNED        NOT NULL
  COMMENT 'ID of title from AniDB',
  episodeid     INT(10) UNSIGNED        NOT NULL DEFAULT '0'
  COMMENT 'anidb id for this episode',
  episode_no    SMALLINT(5) UNSIGNED    NOT NULL
  COMMENT 'Numeric version of episode (leave 0 for combined episodes).',
  episode_title VARCHAR(255)
                COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Title of the episode (en, x-jat)',
  airdate       DATE                    NOT NULL,
  PRIMARY KEY (anidbid, episodeid)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS anidb_info;
CREATE TABLE anidb_info (
  anidbid     INT(10) UNSIGNED NOT NULL
  COMMENT 'ID of title from AniDB',
  type        VARCHAR(32)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  startdate   DATE                    DEFAULT NULL,
  enddate     DATE                    DEFAULT NULL,
  updated     TIMESTAMP               DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  related     VARCHAR(1024)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  similar     VARCHAR(1024)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  creators    VARCHAR(1024)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  description TEXT
              COLLATE utf8_unicode_ci DEFAULT NULL,
  rating      VARCHAR(5)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  picture     VARCHAR(255)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  categories  VARCHAR(1024)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  characters  VARCHAR(1024)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (anidbid),
  KEY ix_anidb_info_datetime (startdate, enddate, updated)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS anidb_titles;
CREATE TABLE anidb_titles (
  anidbid INT(10) UNSIGNED        NOT NULL
  COMMENT 'ID of title from AniDB',
  type    VARCHAR(25)
          COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'type of title.',
  lang    VARCHAR(25)
          COLLATE utf8_unicode_ci NOT NULL,
  title   VARCHAR(255)
          COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (anidbid, type, lang, title)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS audio_data;
CREATE TABLE audio_data (
  id               INT(11)     UNSIGNED AUTO_INCREMENT,
  releases_id      INT(11)     UNSIGNED NOT NULL COMMENT 'FK to releases.id',
  audioid          INT(2)      UNSIGNED NOT NULL,
  audioformat      VARCHAR(50) DEFAULT NULL,
  audiomode        VARCHAR(50) DEFAULT NULL,
  audiobitratemode VARCHAR(50) DEFAULT NULL,
  audiobitrate     VARCHAR(10) DEFAULT NULL,
  audiochannels    VARCHAR(25) DEFAULT NULL,
  audiosamplerate  VARCHAR(25) DEFAULT NULL,
  audiolibrary     VARCHAR(50) DEFAULT NULL,
  audiolanguage    VARCHAR(50) DEFAULT NULL,
  audiotitle       VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX ix_releaseaudio_releaseid_audioid (releases_id, audioid)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS binaries;
CREATE TABLE binaries (
  id            BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  name          VARCHAR(1000)       NOT NULL DEFAULT '',
  collections_id INT(11) UNSIGNED    NOT NULL DEFAULT 0,
  filenumber    INT UNSIGNED        NOT NULL DEFAULT '0',
  totalparts    INT(11) UNSIGNED    NOT NULL DEFAULT 0,
  currentparts  INT UNSIGNED        NOT NULL DEFAULT 0,
  binaryhash    BINARY(16)          NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  partcheck     TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  partsize      BIGINT UNSIGNED     NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  CONSTRAINT FK_Collections FOREIGN KEY (collections_id)
  REFERENCES collections(id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE INDEX ix_binaries_binaryhash (binaryhash),
  INDEX ix_binaries_partcheck  (partcheck),
  INDEX ix_binaries_collection (collections_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS bookinfo;
CREATE TABLE bookinfo (
  id          INT(10) UNSIGNED    NOT NULL AUTO_INCREMENT,
  title       VARCHAR(255)        NOT NULL,
  author      VARCHAR(255)        NOT NULL,
  asin        VARCHAR(128)     DEFAULT NULL,
  isbn        VARCHAR(128)     DEFAULT NULL,
  ean         VARCHAR(128)     DEFAULT NULL,
  url         VARCHAR(1000)    DEFAULT NULL,
  salesrank   INT(10) UNSIGNED DEFAULT NULL,
  publisher   VARCHAR(255)     DEFAULT NULL,
  publishdate DATETIME         DEFAULT NULL,
  pages       VARCHAR(128)     DEFAULT NULL,
  overview    VARCHAR(3000)    DEFAULT NULL,
  genre       VARCHAR(255)        NOT NULL,
  cover       TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  created_at DATETIME            NOT NULL,
  updated_at DATETIME            NOT NULL,
  PRIMARY KEY (id),
  FULLTEXT INDEX ix_bookinfo_author_title_ft (author, title),
  UNIQUE INDEX ix_bookinfo_asin (asin)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS consoleinfo;
CREATE TABLE consoleinfo (
  id          INT(10) UNSIGNED    NOT NULL AUTO_INCREMENT,
  title       VARCHAR(255)        NOT NULL,
  asin        VARCHAR(128)                 DEFAULT NULL,
  url         VARCHAR(1000)                DEFAULT NULL,
  salesrank   INT(10) UNSIGNED             DEFAULT NULL,
  platform    VARCHAR(255)                 DEFAULT NULL,
  publisher   VARCHAR(255)                 DEFAULT NULL,
  genres_id    INT(10)             NULL     DEFAULT NULL,
  esrb        VARCHAR(255)        NULL     DEFAULT NULL,
  releasedate DATETIME                     DEFAULT NULL,
  review      VARCHAR(3000)                DEFAULT NULL,
  cover       TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  created_at DATETIME            NOT NULL,
  updated_at DATETIME            NOT NULL,
  PRIMARY KEY (id),
  FULLTEXT INDEX ix_consoleinfo_title_platform_ft (title, platform),
  UNIQUE INDEX ix_consoleinfo_asin (asin)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS dnzb_failures;
CREATE TABLE dnzb_failures (
  release_id   INT(11) UNSIGNED  NOT NULL,
  users_id      INT(16) UNSIGNED  NOT NULL,
  failed      INT UNSIGNED      NOT NULL DEFAULT '0',
  PRIMARY KEY (release_id, users_id),
  CONSTRAINT FK_users_df FOREIGN KEY (users_id)
  REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;

DROP TABLE IF EXISTS gamesinfo;
CREATE TABLE gamesinfo (
  id          INT(10) UNSIGNED    NOT NULL AUTO_INCREMENT,
  title       VARCHAR(255)        NOT NULL,
  asin        VARCHAR(128)                 DEFAULT NULL,
  url         VARCHAR(1000)                DEFAULT NULL,
  publisher   VARCHAR(255)                 DEFAULT NULL,
  genres_id    INT(10)             NULL     DEFAULT NULL,
  esrb        VARCHAR(255)        NULL     DEFAULT NULL,
  releasedate DATETIME                     DEFAULT NULL,
  review      VARCHAR(3000)                DEFAULT NULL,
  cover       TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  backdrop    TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  trailer     VARCHAR(1000)       NOT NULL DEFAULT '',
  classused   VARCHAR(10)         NOT NULL DEFAULT 'steam',
  created_at DATETIME            NOT NULL,
  updated_at DATETIME            NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX  ix_gamesinfo_asin (asin),
  INDEX         ix_title (title),
  FULLTEXT INDEX ix_title_ft (title)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS invitations;
CREATE TABLE invitations (
  id          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  guid        VARCHAR(50)      NOT NULL,
  users_id INT(16) UNSIGNED NOT NULL,
  created_at DATETIME         NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_users_inv FOREIGN KEY (users_id)
  REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS logging;
CREATE TABLE logging (
  id       INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  time     DATETIME    DEFAULT NULL,
  username VARCHAR(50) DEFAULT NULL,
  host     VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS missed_parts;
CREATE TABLE missed_parts (
  id       INT(16) UNSIGNED NOT NULL AUTO_INCREMENT,
  numberid BIGINT UNSIGNED  NOT NULL,
  groups_id INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'FK to groups.id',
  attempts TINYINT(1)       NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  INDEX ix_missed_parts_attempts                  (attempts),
  INDEX ix_missed_parts_groupid_attempts          (groups_id, attempts),
  INDEX ix_missed_parts_numberid_groupsid_attempts (numberid, groups_id, attempts),
  UNIQUE INDEX ix_missed_parts_numberid_groupsid          (numberid, groups_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS movieinfo;
CREATE TABLE movieinfo (
  id          INT(10) UNSIGNED               NOT NULL AUTO_INCREMENT,
  imdbid      MEDIUMINT(7) UNSIGNED ZEROFILL NOT NULL,
  tmdbid      INT(10) UNSIGNED               NOT NULL DEFAULT 0,
  title       VARCHAR(255)                   NOT NULL DEFAULT '',
  tagline     VARCHAR(1024)                  NOT NULL DEFAULT '',
  rating      VARCHAR(4)                     NOT NULL DEFAULT '',
  rtrating    VARCHAR(10)                    NOT NULL DEFAULT '' COMMENT 'RottenTomatoes rating score',
  plot        VARCHAR(1024)                  NOT NULL DEFAULT '',
  year        VARCHAR(4)                     NOT NULL DEFAULT '',
  genre       VARCHAR(64)                    NOT NULL DEFAULT '',
  type        VARCHAR(32)                    NOT NULL DEFAULT '',
  director    VARCHAR(64)                    NOT NULL DEFAULT '',
  actors      VARCHAR(2000)                  NOT NULL DEFAULT '',
  language    VARCHAR(64)                    NOT NULL DEFAULT '',
  cover       TINYINT(1) UNSIGNED            NOT NULL DEFAULT '0',
  backdrop    TINYINT(1) UNSIGNED            NOT NULL DEFAULT '0',
  created_at DATETIME                       NOT NULL,
  updated_at DATETIME                       NOT NULL,
  trailer     VARCHAR(255)                   NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  INDEX ix_movieinfo_title  (title),
  UNIQUE INDEX ix_movieinfo_imdbid (imdbid)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS musicinfo;
CREATE TABLE musicinfo (
  id          INT(10) UNSIGNED    NOT NULL AUTO_INCREMENT,
  title       VARCHAR(255)        NOT NULL,
  asin        VARCHAR(128)        NULL,
  url         VARCHAR(1000)       NULL,
  salesrank   INT(10) UNSIGNED    NULL,
  artist      VARCHAR(255)        NULL,
  publisher   VARCHAR(255)        NULL,
  releasedate DATETIME            NULL,
  review      VARCHAR(3000)       NULL,
  year        VARCHAR(4)          NOT NULL,
  genres_id INT(10)             NULL,
  tracks      VARCHAR(3000)       NULL,
  cover       TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  created_at DATETIME            NOT NULL,
  updated_at DATETIME            NOT NULL,
  PRIMARY KEY (id),
  FULLTEXT INDEX ix_musicinfo_artist_title_ft (artist, title),
  UNIQUE INDEX ix_musicinfo_asin (asin)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS multigroup_collections;
CREATE TABLE         multigroup_collections (
  id             INT(11) UNSIGNED    NOT NULL AUTO_INCREMENT,
  subject        VARCHAR(255)        NOT NULL DEFAULT '',
  fromname       VARCHAR(255)        NOT NULL DEFAULT '',
  date           DATETIME            DEFAULT NULL,
  xref           VARCHAR(2000)        NOT NULL DEFAULT '',
  totalfiles     INT(11) UNSIGNED    NOT NULL DEFAULT '0',
  groups_id       INT(11) UNSIGNED    NOT NULL DEFAULT '0',
  collectionhash VARCHAR(255)        NOT NULL DEFAULT '0',
  collection_regexes_id INT SIGNED NOT NULL DEFAULT '0' COMMENT 'FK to collection_regexes.id',
  dateadded      DATETIME            DEFAULT NULL,
  added          TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
  filecheck      TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  filesize       BIGINT UNSIGNED     NOT NULL DEFAULT '0',
  releases_id      INT                 NULL,
  noise          CHAR(32)            NOT NULL DEFAULT '',
  PRIMARY KEY                               (id),
  INDEX        fromname                     (fromname),
  INDEX        date                         (date),
  INDEX        groups_id                     (groups_id),
  INDEX        ix_collection_filecheck      (filecheck),
  INDEX        ix_collection_dateadded      (dateadded),
  INDEX        ix_collection_releaseid      (releases_id),
  UNIQUE INDEX ix_collection_collectionhash (collectionhash)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS multigroup_posters;
CREATE TABLE multigroup_posters (
  id             INT(11) UNSIGNED    NOT NULL AUTO_INCREMENT,
  poster       VARCHAR(255)        NOT NULL DEFAULT '',
  PRIMARY KEY (id) ,
  UNIQUE KEY (poster)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS par_hashes;
CREATE TABLE par_hashes (
  releases_id INT(11) UNSIGNED NOT NULL COMMENT 'FK to releases.id',
  hash VARCHAR(32) NOT NULL COMMENT 'hash_16k block of par2',
  PRIMARY KEY (releases_id, hash)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;

DROP TABLE IF EXISTS parts;
CREATE TABLE parts (
  binaries_id      BIGINT(20) UNSIGNED                   NOT NULL DEFAULT '0',
  messageid     VARCHAR(255)        CHARACTER SET latin1 NOT NULL DEFAULT '',
  number        BIGINT UNSIGNED                          NOT NULL DEFAULT '0',
  partnumber    MEDIUMINT UNSIGNED                       NOT NULL DEFAULT '0',
  size          MEDIUMINT UNSIGNED                       NOT NULL DEFAULT '0',
  PRIMARY KEY (binaries_id,number),
  CONSTRAINT FK_binaries FOREIGN KEY (binaries_id)
  REFERENCES binaries(id) ON DELETE CASCADE ON UPDATE CASCADE
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS predb;
CREATE TABLE predb (
  id         INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  title      VARCHAR(255)     NOT NULL DEFAULT '',
  nfo        VARCHAR(255)     NULL,
  size       VARCHAR(50)      NULL,
  category   VARCHAR(255)     NULL,
  predate    DATETIME                  DEFAULT NULL,
  source     VARCHAR(50)      NOT NULL DEFAULT '',
  requestid  INT(10) UNSIGNED NOT NULL DEFAULT '0',
  groups_id  INT(10) UNSIGNED NOT NULL DEFAULT '0'  COMMENT 'FK to groups',
  nuked      TINYINT(1)       NOT NULL DEFAULT '0'  COMMENT 'Is this pre nuked? 0 no 2 yes 1 un nuked 3 mod nuked',
  nukereason VARCHAR(255)     NULL  COMMENT 'If this pre is nuked, what is the reason?',
  files      VARCHAR(50)      NULL  COMMENT 'How many files does this pre have ?',
  filename   VARCHAR(255)     NOT NULL DEFAULT '',
  searched   TINYINT(1)       NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  UNIQUE INDEX ix_predb_title     (title),
  INDEX ix_predb_nfo       (nfo),
  INDEX ix_predb_predate   (predate),
  INDEX ix_predb_source    (source),
  INDEX ix_predb_requestid (requestid, groups_id),
  INDEX ix_predb_filename  (filename),
  FULLTEXT INDEX ft_predb_filename (filename),
  INDEX ix_predb_searched  (searched)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS predb_hashes;
CREATE TABLE predb_hashes (
  predb_id INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'id, of the predb entry, this hash belongs to',
  hash VARBINARY(40)      NOT NULL DEFAULT '',
  PRIMARY KEY (hash)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE         = utf8mb4_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS predb_imports;
CREATE TABLE predb_imports (
  title      VARCHAR(255)
               COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  nfo        VARCHAR(255)
               COLLATE utf8_unicode_ci          DEFAULT NULL,
  size       VARCHAR(50)
               COLLATE utf8_unicode_ci          DEFAULT NULL,
  category   VARCHAR(255)
               COLLATE utf8_unicode_ci          DEFAULT NULL,
  predate    DATETIME                         DEFAULT NULL,
  source     VARCHAR(50)
               COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  requestid  INT(10) UNSIGNED        NOT NULL DEFAULT '0',
  groups_id   INT(10) UNSIGNED        NOT NULL DEFAULT '0' COMMENT 'FK to groups',
  nuked      TINYINT(1)              NOT NULL DEFAULT '0'  COMMENT 'Is this pre nuked? 0 no 2 yes 1 un nuked 3 mod nuked',
  nukereason VARCHAR(255)
               COLLATE utf8_unicode_ci          DEFAULT NULL
  COMMENT 'If this pre is nuked, what is the reason?',
  files      VARCHAR(50)
               COLLATE utf8_unicode_ci          DEFAULT NULL
  COMMENT 'How many files does this pre have ?',
  filename   VARCHAR(255)
               COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  searched   TINYINT(1)              NOT NULL DEFAULT '0',
  groupname  VARCHAR(255)
               COLLATE utf8_unicode_ci          DEFAULT NULL
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS release_comments;
CREATE TABLE release_comments (
  id          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  releases_id INT(11) UNSIGNED NOT NULL COMMENT 'FK to releases.id',
  text        VARCHAR(2000)    NOT NULL DEFAULT '',
  isvisible   TINYINT(1)       NOT NULL DEFAULT '1',
  issynced    TINYINT(1)       NOT NULL DEFAULT '0',
  gid         VARCHAR(32)      NULL,
  cid         VARCHAR(32)      NULL,
  text_hash   VARCHAR(32)      NOT NULL DEFAULT '',
  username    VARCHAR(255)     NOT NULL DEFAULT '',
  users_id     INT(16) UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  host        VARCHAR(15)      NULL,
  shared      TINYINT(1)       NOT NULL DEFAULT '0',
  shareid     VARCHAR(40)      NOT NULL DEFAULT '',
  siteid      VARCHAR(40)      NOT NULL DEFAULT '',
  sourceid    BIGINT(20)       UNSIGNED,
  nzb_guid    BINARY(16)       NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  PRIMARY KEY (id),
  UNIQUE INDEX ix_release_comments_hash_releases_id(text_hash, releases_id),
  INDEX ix_releasecomment_releases_id (releases_id),
  INDEX ix_releasecomment_userid    (users_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS releases_groups;
CREATE TABLE releases_groups (
  releases_id INT(11) UNSIGNED NOT NULL DEFAULT '0'
  COMMENT 'FK to releases.id',
  groups_id   INT(11) UNSIGNED NOT NULL DEFAULT '0'
  COMMENT 'FK to groups.id',
  PRIMARY KEY (releases_id, groups_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;

DROP TABLE IF EXISTS release_regexes;
CREATE TABLE release_regexes (
  releases_id           INT(11) UNSIGNED    NOT NULL DEFAULT '0',
  collection_regex_id   INT(11) NOT NULL DEFAULT '0',
  naming_regex_id       INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (releases_id, collection_regex_id, naming_regex_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS release_unique;
CREATE TABLE release_unique (
  releases_id   INT(11) UNSIGNED  NOT NULL COMMENT 'FK to releases.id.',
  uniqueid BINARY(16)  NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0' COMMENT 'Unique_ID from mediainfo.',
  PRIMARY KEY (releases_id, uniqueid)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS releaseextrafull;
CREATE TABLE releaseextrafull (
  releases_id INT(11) UNSIGNED NOT NULL COMMENT 'FK to releases.id',
  mediainfo   TEXT NULL,
  PRIMARY KEY (releases_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS release_files;
CREATE TABLE release_files (
  releases_id int(11) unsigned NOT NULL COMMENT 'FK to releases.id',
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  size bigint(20) unsigned NOT NULL DEFAULT '0',
  ishashed tinyint(1) NOT NULL DEFAULT '0',
  created_at datetime NOT NULL,
  updated_at DATETIME NOT NULL,
  passworded tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (releases_id, name),
  KEY ix_releasefiles_ishashed (ishashed)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;

DROP TABLE IF EXISTS release_nfos;
CREATE TABLE release_nfos (
  releases_id INT(11) UNSIGNED NOT NULL COMMENT 'FK to releases.id',
  nfo       BLOB             NULL DEFAULT NULL,
  PRIMARY KEY (releases_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = COMPRESSED;


DROP TABLE IF EXISTS release_search_data;
CREATE TABLE release_search_data (
  id         INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  releases_id  INT(11) UNSIGNED NOT NULL COMMENT 'FK to releases.id',
  guid       VARCHAR(50)      NOT NULL,
  name       VARCHAR(255)     NOT NULL DEFAULT '',
  searchname VARCHAR(255)     NOT NULL DEFAULT '',
  fromname   VARCHAR(255)     NULL,
  PRIMARY KEY                                        (id),
  FULLTEXT INDEX ix_releasesearch_name_ft (name),
  FULLTEXT INDEX ix_releasesearch_searchname_ft (searchname),
  FULLTEXT INDEX ix_releasesearch_fromname_ft (fromname),
  INDEX          ix_releasesearch_releases_id          (releases_id),
  INDEX          ix_releasesearch_guid               (guid)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS release_subtitles;
CREATE TABLE release_subtitles (
  id           INT(11)     UNSIGNED AUTO_INCREMENT,
  releases_id    INT(11)     UNSIGNED NOT NULL COMMENT 'FK to releases.id',
  subsid       INT(2)      UNSIGNED NOT NULL,
  subslanguage VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX ix_releasesubs_releases_id_subsid (releases_id, subsid)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS sharing;
CREATE TABLE sharing (
  site_guid      VARCHAR(40)        NOT NULL DEFAULT '',
  site_name      VARCHAR(255)       NOT NULL DEFAULT '',
  username       VARCHAR(255)       NOT NULL DEFAULT '',
  enabled        TINYINT(1)         NOT NULL DEFAULT '0',
  posting        TINYINT(1)         NOT NULL DEFAULT '0',
  fetching       TINYINT(1)         NOT NULL DEFAULT '1',
  auto_enable    TINYINT(1)         NOT NULL DEFAULT '1',
  start_position TINYINT(1)         NOT NULL DEFAULT '0',
  hide_users     TINYINT(1)         NOT NULL DEFAULT '1',
  last_article   BIGINT UNSIGNED    NOT NULL DEFAULT '0',
  max_push       MEDIUMINT UNSIGNED NOT NULL DEFAULT '40',
  max_download   MEDIUMINT UNSIGNED NOT NULL DEFAULT '150',
  max_pull       MEDIUMINT UNSIGNED NOT NULL DEFAULT '20000',
  PRIMARY KEY (site_guid)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS sharing_sites;
CREATE TABLE sharing_sites (
  id         INT(11) UNSIGNED   NOT NULL AUTO_INCREMENT,
  site_name  VARCHAR(255)       NOT NULL DEFAULT '',
  site_guid  VARCHAR(40)        NOT NULL DEFAULT '',
  last_time  DATETIME DEFAULT NULL,
  first_time DATETIME DEFAULT NULL,
  enabled    TINYINT(1)         NOT NULL DEFAULT '0',
  comments   MEDIUMINT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS short_groups;
CREATE TABLE short_groups (
  id           INT(11)         NOT NULL AUTO_INCREMENT,
  name         VARCHAR(255)    NOT NULL DEFAULT '',
  first_record BIGINT UNSIGNED NOT NULL DEFAULT '0',
  last_record  BIGINT UNSIGNED NOT NULL DEFAULT '0',
  updated      DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX ix_shortgroups_name (name)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS steam_apps;
CREATE TABLE steam_apps (
  name         VARCHAR(255)        NOT NULL DEFAULT '' COMMENT 'Steam application name',
  appid        INT(11) UNSIGNED    NULL COMMENT 'Steam application id',
  PRIMARY KEY (appid, name),
  FULLTEXT INDEX ix_name_ft (name)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;

DROP TABLE IF EXISTS tv_episodes;
CREATE TABLE tv_episodes (
  id           INT(11)        UNSIGNED NOT NULL AUTO_INCREMENT,
  videos_id    MEDIUMINT(11)  UNSIGNED  NOT NULL COMMENT 'FK to videos.id of the parent series.',
  series       SMALLINT(5)    UNSIGNED    NOT NULL DEFAULT '0' COMMENT 'Number of series/season.',
  episode      SMALLINT(5)    UNSIGNED    NOT NULL DEFAULT '0' COMMENT 'Number of episode within series',
  se_complete  VARCHAR(10)    COLLATE utf8_unicode_ci NOT NULL COMMENT 'String version of Series/Episode as taken from release subject (i.e. S02E21+22).',
  title        VARCHAR(180)   CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Title of the episode.',
  firstaired   DATE           NOT NULL COMMENT 'Date of original airing/release.',
  summary      TEXT           CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Description/summary of the episode.',
  PRIMARY KEY (id),
  UNIQUE KEY (videos_id, series, episode, firstaired)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS tv_info;
CREATE TABLE tv_info (
  videos_id MEDIUMINT(11) UNSIGNED  NOT NULL DEFAULT '0' COMMENT 'FK to video.id',
  summary   TEXT          CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Description/summary of the show.',
  publisher VARCHAR(50)   CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The channel/network of production/release (ABC, BBC, Showtime, etc.).',
  localzone VARCHAR(50)   CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The linux tz style identifier',
  image     TINYINT(1)    UNSIGNED  NOT NULL DEFAULT '0' COMMENT 'Does the video have a cover image?',
  PRIMARY KEY          (videos_id),
  KEY ix_tv_info_image (image)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS upcoming_releases;
CREATE TABLE upcoming_releases (
  id          INT(10)                               NOT NULL AUTO_INCREMENT,
  source      VARCHAR(20)                           NOT NULL,
  typeid      INT(10)                               NOT NULL,
  info        TEXT                                  NULL,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE INDEX ix_upcoming_source (source, typeid)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS users_releases;
CREATE TABLE users_releases (
  id          INT(16) UNSIGNED NOT NULL AUTO_INCREMENT,
  users_id INT(16) UNSIGNED    NOT NULL,
  releases_id   INT(11) UNSIGNED              NOT NULL COMMENT 'FK to releases.id',
  created_at DATETIME         NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_users_ur FOREIGN KEY (users_id)
  REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE INDEX ix_usercart_userrelease (users_id, releases_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS user_downloads;
CREATE TABLE user_downloads (
  id          INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  users_id    INT(16) UNSIGNED  NOT NULL,
  hosthash    VARCHAR(50)       NOT NULL DEFAULT '',
  timestamp   DATETIME          NOT NULL,
  releases_id INT(11) UNSIGNED           NOT NULL COMMENT 'FK to releases.id',
  PRIMARY KEY (id),
  CONSTRAINT FK_users_ud FOREIGN KEY (users_id)
  REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  KEY userid    (users_id),
  KEY timestamp (timestamp)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS user_excluded_categories;
CREATE TABLE user_excluded_categories (
  id          INT(16) UNSIGNED NOT NULL AUTO_INCREMENT,
  users_id    INT(16) UNSIGNED  NOT NULL,
  categories_id  INT              NOT NULL,
  created_at DATETIME         NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_users_uec FOREIGN KEY (users_id)
  REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE INDEX ix_userexcat_usercat (users_id, categories_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS role_excluded_categories;
CREATE TABLE role_excluded_categories
(
    id              INT(16) UNSIGNED NOT NULL AUTO_INCREMENT,
    user_roles_id            INT(11) NOT NULL,
    categories_id   INT(11),
    created_at     DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE INDEX ix_roleexcat_rolecat (user_roles_id, categories_id)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8
    COLLATE = utf8_unicode_ci
    AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS user_movies;
CREATE TABLE user_movies (
  id          INT(16) UNSIGNED               NOT NULL AUTO_INCREMENT,
  users_id    INT(16) UNSIGNED  NOT NULL,
  imdbid      MEDIUMINT(7) UNSIGNED ZEROFILL NULL,
  categories  VARCHAR(64)                    NULL DEFAULT NULL COMMENT 'List of categories for user movies',
  created_at DATETIME                       NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_users_um FOREIGN KEY (users_id)
  REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX ix_usermovies_userid (users_id, imdbid)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS user_requests;
CREATE TABLE user_requests (
  id        INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  users_id    INT(16) UNSIGNED  NOT NULL,
  hosthash VARCHAR(50)      NOT NULL DEFAULT '',
  request   VARCHAR(255)     NOT NULL,
  timestamp DATETIME         NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_users_urq FOREIGN KEY (users_id)
  REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  KEY userid    (users_id),
  KEY timestamp (timestamp)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS user_series;
CREATE TABLE user_series (
  id          INT(16) UNSIGNED NOT NULL AUTO_INCREMENT,
  users_id    INT(16) UNSIGNED  NOT NULL,
  videos_id   INT(16)          NOT NULL COMMENT 'FK to videos.id',
  categories  VARCHAR(64)      NULL DEFAULT NULL COMMENT 'List of categories for user tv shows',
  created_at DATETIME         NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_users_us FOREIGN KEY (users_id)
  REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX ix_userseries_videos_id (users_id, videos_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DROP TABLE IF EXISTS video_data;
CREATE TABLE video_data (
  releases_id       INT(11) UNSIGNED NOT NULL COMMENT 'FK to releases.id',
  containerformat VARCHAR(50) DEFAULT NULL,
  overallbitrate  VARCHAR(20) DEFAULT NULL,
  videoduration   VARCHAR(20) DEFAULT NULL,
  videoformat     VARCHAR(50) DEFAULT NULL,
  videocodec      VARCHAR(50) DEFAULT NULL,
  videowidth      INT(10)     DEFAULT NULL,
  videoheight     INT(10)     DEFAULT NULL,
  videoaspect     VARCHAR(10) DEFAULT NULL,
  videoframerate  FLOAT(7, 4) DEFAULT NULL,
  videolibrary    VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (releases_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC;


DROP TABLE IF EXISTS videos;
CREATE TABLE videos (
  id           MEDIUMINT(11) UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT 'Show ID to be used in other tables as reference ',
  type         TINYINT(1) UNSIGNED     NOT NULL DEFAULT '0' COMMENT '0 = TV, 1 = Film, 2 = Anime',
  title        VARCHAR(180) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Name of the video.',
  countries_id CHAR(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Two character country code (FK to countries table).',
  started      DATETIME                NOT NULL COMMENT 'Date (UTC) of production''s first airing.',
  anidb        MEDIUMINT(11) UNSIGNED NOT NULL DEFAULT '0'  COMMENT 'ID number for anidb site',
  imdb         MEDIUMINT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID number for IMDB site (without the ''tt'' prefix).',
  tmdb         MEDIUMINT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID number for TMDB site.',
  trakt        MEDIUMINT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID number for TraktTV site.',
  tvdb         MEDIUMINT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID number for TVDB site',
  tvmaze       MEDIUMINT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID number for TVMaze site.',
  tvrage       MEDIUMINT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID number for TVRage site.',
  source       TINYINT(1)    UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Which site did we use for info?',
  PRIMARY KEY    (id),
  UNIQUE KEY     ix_videos_title (title, type, started, countries_id),
  KEY            ix_videos_imdb (imdb),
  KEY            ix_videos_tmdb (tmdb),
  KEY            ix_videos_trakt (trakt),
  KEY            ix_videos_tvdb (tvdb),
  KEY            ix_videos_tvmaze (tvmaze),
  KEY            ix_videos_tvrage (tvrage),
  KEY            ix_videos_type_source (type, source)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  AUTO_INCREMENT = 10000000;

DROP TABLE IF EXISTS videos_aliases;
CREATE TABLE videos_aliases (
  videos_id   MEDIUMINT(11) UNSIGNED  NOT NULL COMMENT 'FK to videos.id of the parent title.',
  title VARCHAR(180) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'AKA of the video.',
  PRIMARY KEY (videos_id, title)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  AUTO_INCREMENT  = 10000000;

DROP TABLE IF EXISTS xxxinfo;
CREATE TABLE         xxxinfo (
  id          INT(10) UNSIGNED               NOT NULL AUTO_INCREMENT,
  title       VARCHAR(1024)                   NOT NULL,
  tagline     VARCHAR(1024)                  NOT NULL,
  plot        BLOB                           NULL DEFAULT NULL,
  genre       VARCHAR(255)                    NOT NULL,
  director    VARCHAR(255)                    DEFAULT NULL,
  actors      VARCHAR(2500)                  NOT NULL,
  extras      TEXT                           DEFAULT NULL,
  productinfo TEXT                           DEFAULT NULL,
  trailers    TEXT                           DEFAULT NULL,
  directurl   VARCHAR(2000)                  NOT NULL,
  classused   VARCHAR(20)                    NOT NULL DEFAULT '',
  cover       TINYINT(1) UNSIGNED            NOT NULL DEFAULT '0',
  backdrop    TINYINT(1) UNSIGNED            NOT NULL DEFAULT '0',
  created_at DATETIME                       NOT NULL,
  updated_at DATETIME                       NOT NULL,
  PRIMARY KEY                   (id),
  UNIQUE INDEX ix_xxxinfo_title (title)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = COMPRESSED
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS multigroup_binaries;
CREATE TABLE multigroup_binaries (
  id            BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  name          VARCHAR(1000)       NOT NULL DEFAULT '',
  collections_id INT(11) UNSIGNED    NOT NULL DEFAULT 0,
  filenumber    INT UNSIGNED        NOT NULL DEFAULT '0',
  totalparts    INT(11) UNSIGNED    NOT NULL DEFAULT 0,
  currentparts  INT UNSIGNED        NOT NULL DEFAULT 0,
  binaryhash    BINARY(16)          NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  partcheck     TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  partsize      BIGINT UNSIGNED     NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  CONSTRAINT FK_MGR_Collections FOREIGN KEY (collections_id)
  REFERENCES multigroup_collections(id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE INDEX ix_binaries_binaryhash (binaryhash),
  INDEX ix_binaries_partcheck  (partcheck),
  INDEX ix_binaries_collection (collections_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS multigroup_parts;
CREATE TABLE multigroup_parts (
  binaries_id      BIGINT(20) UNSIGNED                      NOT NULL DEFAULT '0',
  messageid     VARCHAR(255)        CHARACTER SET latin1 NOT NULL DEFAULT '',
  number        BIGINT UNSIGNED                          NOT NULL DEFAULT '0',
  partnumber    MEDIUMINT UNSIGNED                       NOT NULL DEFAULT '0',
  size          MEDIUMINT UNSIGNED                       NOT NULL DEFAULT '0',
  PRIMARY KEY (binaries_id,number),
  CONSTRAINT FK_MGR_binaries FOREIGN KEY (binaries_id)
  REFERENCES multigroup_binaries(id) ON DELETE CASCADE ON UPDATE CASCADE
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;

DROP TABLE IF EXISTS multigroup_missed_parts;
CREATE TABLE multigroup_missed_parts (
  id       INT(16) UNSIGNED NOT NULL AUTO_INCREMENT,
  numberid BIGINT UNSIGNED  NOT NULL,
  groups_id INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'FK to groups.id',
  attempts TINYINT(1)       NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  INDEX ix_missed_parts_attempts                  (attempts),
  INDEX ix_missed_parts_groupid_attempts          (groups_id, attempts),
  INDEX ix_missed_parts_numberid_groupsid_attempts (numberid, groups_id, attempts),
  UNIQUE INDEX ix_missed_parts_numberid_groupsid          (numberid, groups_id)
)
  ENGINE          = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE         = utf8_unicode_ci
  ROW_FORMAT      = DYNAMIC
  AUTO_INCREMENT  = 1;


DELIMITER $$
CREATE TRIGGER check_insert BEFORE INSERT ON releases FOR EACH ROW
  BEGIN
    IF NEW.searchname REGEXP '[a-fA-F0-9]{32}' OR NEW.name REGEXP '[a-fA-F0-9]{32}'
      THEN SET NEW.ishashed = 1;
    END IF;
  END; $$

CREATE TRIGGER check_update BEFORE UPDATE ON releases FOR EACH ROW
  BEGIN
    IF NEW.searchname REGEXP '[a-fA-F0-9]{32}' OR NEW.name REGEXP '[a-fA-F0-9]{32}'
      THEN SET NEW.ishashed = 1;
    END IF;
  END; $$

CREATE TRIGGER check_rfinsert BEFORE INSERT ON release_files FOR EACH ROW
  BEGIN
    IF NEW.name REGEXP '[a-fA-F0-9]{32}'
      THEN SET NEW.ishashed = 1;
    END IF;
  END; $$

CREATE TRIGGER check_rfupdate BEFORE UPDATE ON release_files FOR EACH ROW
  BEGIN
    IF NEW.name REGEXP '[a-fA-F0-9]{32}'
      THEN SET NEW.ishashed = 1;
    END IF;
  END; $$

CREATE TRIGGER insert_search AFTER INSERT ON releases FOR EACH ROW
  BEGIN
    INSERT INTO release_search_data (releases_id, guid, name, searchname, fromname) VALUES (NEW.id, NEW.guid, NEW.name, NEW.searchname, NEW.fromname);
  END; $$

CREATE TRIGGER update_search AFTER UPDATE ON releases FOR EACH ROW
  BEGIN
    IF NEW.guid != OLD.guid
      THEN UPDATE release_search_data SET guid = NEW.guid WHERE releases_id = OLD.id;
    END IF;
    IF NEW.name != OLD.name
      THEN UPDATE release_search_data SET name = NEW.name WHERE releases_id = OLD.id;
    END IF;
    IF NEW.searchname != OLD.searchname
      THEN UPDATE release_search_data SET searchname = NEW.searchname WHERE releases_id = OLD.id;
    END IF;
    IF NEW.fromname != OLD.fromname
      THEN UPDATE release_search_data SET fromname = NEW.fromname WHERE releases_id = OLD.id;
    END IF;
  END; $$

CREATE TRIGGER delete_search AFTER DELETE ON releases FOR EACH ROW
  BEGIN
    DELETE FROM release_search_data WHERE releases_id = OLD.id;
  END; $$

CREATE TRIGGER insert_hashes AFTER INSERT ON predb FOR EACH ROW BEGIN INSERT INTO predb_hashes (hash, predb_id) VALUES (UNHEX(MD5(NEW.title)), NEW.id), (UNHEX(MD5(MD5(NEW.title))), NEW.id), (UNHEX(SHA1(NEW.title)), NEW.id), (UNHEX(SHA2(NEW.title, 256)), NEW.id), (UNHEX(MD5(CONCAT(NEW.title, NEW.requestid))), NEW.id), (UNHEX(MD5(CONCAT(NEW.title, NEW.requestid, NEW.requestid))), NEW.id);END; $$

CREATE TRIGGER update_hashes AFTER UPDATE ON predb FOR EACH ROW BEGIN IF NEW.title != OLD.title THEN DELETE FROM predb_hashes WHERE hash IN ( UNHEX(md5(OLD.title)), UNHEX(md5(md5(OLD.title))), UNHEX(sha1(OLD.title)), UNHEX(sha2(OLD.title, 256)), UNHEX(MD5(CONCAT(OLD.title, OLD.requestid)))) AND predb_id = OLD.id; INSERT INTO predb_hashes (hash, predb_id) VALUES (UNHEX(MD5(NEW.title)), NEW.id), (UNHEX(MD5(MD5(NEW.title))), NEW.id), (UNHEX(SHA1(NEW.title)), NEW.id), (UNHEX(SHA2(NEW.title, 256)), NEW.id), (UNHEX(MD5(CONCAT((NEW.title, NEW.requestid)))), NEW.id), (UNHEX(MD5(CONCAT(NEW.title, NEW.requestid, NEW.requestid))), NEW.id);END IF;END; $$

CREATE TRIGGER delete_hashes AFTER DELETE ON predb FOR EACH ROW BEGIN DELETE FROM predb_hashes WHERE hash IN ( UNHEX(md5(OLD.title)), UNHEX(md5(md5(OLD.title))), UNHEX(sha1(OLD.title)), UNHEX(sha2(OLD.title, 256)), UNHEX(MD5(CONCAT(OLD.title, OLD.requestid))), UNHEX(MD5(CONCAT(OLD.title, OLD.requestid, OLD.requestid)))) AND predb_id = OLD.id;END; $$

CREATE TRIGGER insert_MD5 BEFORE INSERT ON release_comments FOR EACH ROW
  SET
    NEW.text_hash = MD5(NEW.text);$$

#
# Stored Procedures
#
CREATE PROCEDURE loop_cbpm(IN method CHAR(10))
  COMMENT 'Performs tasks on All CBPM tables one by one -- REPAIR/ANALYZE/OPTIMIZE or DROP/TRUNCATE'

    main: BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE tname VARCHAR(255) DEFAULT '';
    DECLARE regstr VARCHAR(255) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '';

    DECLARE cur1 CURSOR FOR
      SELECT TABLE_NAME
      FROM information_schema.TABLES
      WHERE
        TABLE_SCHEMA = (SELECT DATABASE())
        AND TABLE_NAME REGEXP regstr
      ORDER BY TABLE_NAME ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    IF method NOT IN ('repair', 'analyze', 'optimize', 'drop', 'truncate')
    THEN LEAVE main; END IF;

    IF method = 'drop' THEN SET regstr = '^(collections|binaries|parts|missed_parts)_[0-9]+$';
    ELSE SET regstr = '^(multigroup_)?(collections|binaries|parts|missed_parts)(_[0-9]+)?$';
    END IF;

    OPEN cur1;
    cbpm_loop: LOOP FETCH cur1
    INTO tname;
      IF done
      THEN LEAVE cbpm_loop; END IF;
      SET @SQL := CONCAT(method, ' TABLE ', tname);
      PREPARE _stmt FROM @SQL;
      EXECUTE _stmt;
      DEALLOCATE PREPARE _stmt;
    END LOOP;
    CLOSE cur1;
  END;
$$


CREATE PROCEDURE delete_release(IN is_numeric BOOLEAN, IN identifier VARCHAR(40))
  COMMENT 'Cascade deletes release from child tables when parent row is deleted'
  COMMENT 'If is_numeric is true, identifier should be the releases_id, if false the guid'

  main: BEGIN

    DECLARE where_constr VARCHAR(255) DEFAULT '';

    IF is_numeric IS TRUE
    THEN
      DELETE r
      FROM releases r
      WHERE r.id = identifier;

    ELSEIF is_numeric IS FALSE
    THEN
      DELETE r
      FROM releases r
      WHERE r.guid = identifier;

    ELSE LEAVE main;
    END IF;

  END;
  $$

DELIMITER ;
