DROP TABLE IF EXISTS builds;
DROP TABLE IF EXISTS runs;

CREATE TABLE "builds" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "github_user" varchar(500), "github_repository" varchar(500), "git_branch" varchar(100),  "run_script" varchar(5000), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "runs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "build_id" INTEGER, "git_hash" varchar(40), "success" boolean, "output" varchar(50000), "created_at" datetime, "updated_at" datetime);