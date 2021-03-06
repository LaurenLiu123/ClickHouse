SET allow_experimental_live_view = 1;

DROP TABLE IF EXISTS test.lv;
DROP TABLE IF EXISTS test.mt;

CREATE TABLE test.mt (a Int32) Engine=MergeTree order by tuple();
CREATE LIVE VIEW test.lv AS SELECT * FROM ( SELECT sum(boo.x) FROM ( SELECT foo.x FROM (SELECT a AS x FROM test.mt) AS foo) AS boo );

INSERT INTO test.mt VALUES (1),(2),(3);

SELECT *,_version FROM test.lv;
SELECT *,_version FROM test.lv;

INSERT INTO test.mt VALUES (1),(2),(3);

SELECT *,_version FROM test.lv;
SELECT *,_version FROM test.lv;

DROP TABLE test.lv;
DROP TABLE test.mt;

