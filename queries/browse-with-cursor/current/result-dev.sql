 Limit  (cost=9354.97..9564.93 rows=11 width=412) (actual time=116.904..117.022 rows=11 loops=1)
   Buffers: shared hit=1050, temp read=935 written=937
   ->  Result  (cost=9354.97..356251.19 rows=18174 width=412) (actual time=116.902..117.019 rows=11 loops=1)
         Buffers: shared hit=1050, temp read=935 written=937
         ->  Sort  (cost=9354.97..9400.40 rows=18174 width=348) (actual time=116.830..116.843 rows=11 loops=1)
               Sort Key: (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1)) DESC, "Mod".id DESC
               Sort Method: top-N heapsort  Memory: 41kB
               Buffers: shared hit=978, temp read=935 written=937
               ->  GroupAggregate  (cost=8131.91..8949.74 rows=18174 width=348) (actual time=35.339..114.729 rows=4589 loops=1)
                     Group Key: "Mod".id, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                     Buffers: shared hit=978, temp read=935 written=937
                     ->  Sort  (cost=8131.91..8177.34 rows=18174 width=631) (actual time=35.291..37.710 rows=18301 loops=1)
                           Sort Key: "Mod".id DESC, category.id, categoryparent.id, ratingsub.pos_count, ratingsub.neg_count
                           Sort Method: external merge  Disk: 7480kB
                           Buffers: shared hit=978, temp read=935 written=937
                           ->  Hash Right Join  (cost=1003.16..1750.13 rows=18174 width=631) (actual time=12.575..22.995 rows=18301 loops=1)
                                 Hash Cond: ("ModDownload"."modId" = "Mod".id)
                                 Buffers: shared hit=978
                                 ->  Seq Scan on "ModDownload"  (cost=0.00..497.00 rows=18200 width=136) (actual time=0.007..4.537 rows=18200 loops=1)
                                       Buffers: shared hit=315
                                 ->  Hash  (cost=945.48..945.48 rows=4615 width=499) (actual time=12.557..12.568 rows=4595 loops=1)
                                       Buckets: 8192  Batches: 1  Memory Usage: 1439kB
                                       Buffers: shared hit=663
                                       ->  Hash Left Join  (cost=756.88..945.48 rows=4615 width=499) (actual time=4.361..11.258 rows=4595 loops=1)
                                             Hash Cond: ("Mod".id = "ModRating"."modId")
                                             Buffers: shared hit=663
                                             ->  Hash Left Join  (cost=754.92..931.39 rows=4615 width=436) (actual time=4.349..10.262 rows=4595 loops=1)
                                                   Hash Cond: ("Mod".id = "ModInstaller"."modId")
                                                   Buffers: shared hit=662
                                                   ->  Hash Left Join  (cost=702.58..846.94 rows=4615 width=436) (actual time=3.961..8.742 rows=4595 loops=1)
                                                         Hash Cond: (category."parentId" = categoryparent.id)
                                                         Buffers: shared hit=643
                                                         ->  Hash Left Join  (cost=700.79..831.57 rows=4615 width=340) (actual time=3.943..7.849 rows=4595 loops=1)
                                                               Hash Cond: ("Mod"."categoryId" = category.id)
                                                               Buffers: shared hit=642
                                                               ->  Hash Left Join  (cost=699.00..816.20 rows=4615 width=240) (actual time=3.922..6.683 rows=4595 loops=1)
                                                                     Hash Cond: ("Mod".id = ratingsub."modId")
                                                                     Filter: (((((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) = 1) AND ("Mod".id <= 14375)) OR (((COALESCE(ratingsub.pos_count, '0'::bigint) - COALESCE(ratingsub.neg_count, '0'::bigint)) + 1) < 1))
                                                                     Rows Removed by Filter: 12
                                                                     Buffers: shared hit=641
                                                                     ->  Hash Right Join  (cost=697.00..802.03 rows=4622 width=224) (actual time=3.901..5.552 rows=4607 loops=1)
                                                                           Hash Cond: ("ModSource"."modId" = "Mod".id)
                                                                           Buffers: shared hit=640
                                                                           ->  Seq Scan on "ModSource"  (cost=0.00..92.96 rows=4596 width=4) (actual time=0.006..0.365 rows=4598 loops=1)
                                                                                 Buffers: shared hit=47
                                                                           ->  Hash  (cost=639.22..639.22 rows=4622 width=224) (actual time=3.885..3.886 rows=4599 loops=1)
                                                                                 Buckets: 8192  Batches: 1  Memory Usage: 1228kB
                                                                                 Buffers: shared hit=593
                                                                                 ->  Seq Scan on "Mod"  (cost=0.00..639.22 rows=4622 width=224) (actual time=0.009..2.371 rows=4599 loops=1)
                                                                                       Filter: visible
                                                                                       Buffers: shared hit=593
                                                                     ->  Hash  (cost=1.99..1.99 rows=1 width=20) (actual time=0.014..0.016 rows=0 loops=1)
                                                                           Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                                                           Buffers: shared hit=1
                                                                           ->  Subquery Scan on ratingsub  (cost=1.96..1.99 rows=1 width=20) (actual time=0.014..0.015 rows=0 loops=1)
                                                                                 Buffers: shared hit=1
                                                                                 ->  GroupAggregate  (cost=1.96..1.98 rows=1 width=20) (actual time=0.013..0.014 rows=0 loops=1)
                                                                                       Group Key: "ModRating_1"."modId"
                                                                                       Buffers: shared hit=1
                                                                                       ->  Sort  (cost=1.96..1.97 rows=1 width=5) (actual time=0.013..0.013 rows=0 loops=1)
                                                                                             Sort Key: "ModRating_1"."modId"
                                                                                             Sort Method: quicksort  Memory: 25kB
                                                                                             Buffers: shared hit=1
                                                                                             ->  Seq Scan on "ModRating" "ModRating_1"  (cost=0.00..1.95 rows=1 width=5) (actual time=0.010..0.010 rows=0 loops=1)
                                                                                                   Filter: ("createdAt" > '2024-01-28 11:47:48.889'::timestamp without time zone)
                                                                                                   Rows Removed by Filter: 76
                                                                                                   Buffers: shared hit=1
                                                               ->  Hash  (cost=1.35..1.35 rows=35 width=104) (actual time=0.017..0.018 rows=35 loops=1)
                                                                     Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                                     Buffers: shared hit=1
                                                                     ->  Seq Scan on "Category" category  (cost=0.00..1.35 rows=35 width=104) (actual time=0.003..0.009 rows=35 loops=1)
                                                                           Buffers: shared hit=1
                                                         ->  Hash  (cost=1.35..1.35 rows=35 width=100) (actual time=0.014..0.015 rows=35 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                                               Buffers: shared hit=1
                                                               ->  Seq Scan on "Category" categoryparent  (cost=0.00..1.35 rows=35 width=100) (actual time=0.002..0.007 rows=35 loops=1)
                                                                     Buffers: shared hit=1
                                                   ->  Hash  (cost=33.82..33.82 rows=1482 width=4) (actual time=0.384..0.385 rows=1485 loops=1)
                                                         Buckets: 2048  Batches: 1  Memory Usage: 69kB
                                                         Buffers: shared hit=19
                                                         ->  Seq Scan on "ModInstaller"  (cost=0.00..33.82 rows=1482 width=4) (actual time=0.004..0.187 rows=1485 loops=1)
                                                               Buffers: shared hit=19
                                             ->  Hash  (cost=1.95..1.95 rows=1 width=67) (actual time=0.009..0.010 rows=0 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 8kB
                                                   Buffers: shared hit=1
                                                   ->  Seq Scan on "ModRating"  (cost=0.00..1.95 rows=1 width=67) (actual time=0.009..0.009 rows=0 loops=1)
                                                         Filter: ("userId" = ''::text)
                                                         Rows Removed by Filter: 76
                                                         Buffers: shared hit=1
         SubPlan 1
           ->  Aggregate  (cost=9.53..9.54 rows=1 width=32) (actual time=0.011..0.011 rows=1 loops=11)
                 Buffers: shared hit=44
                 ->  Unique  (cost=0.28..9.51 rows=1 width=110) (actual time=0.005..0.005 rows=1 loops=11)
                       Buffers: shared hit=44
                       ->  Nested Loop Left Join  (cost=0.28..9.50 rows=1 width=110) (actual time=0.005..0.005 rows=1 loops=11)
                             Join Filter: ("ModSource_1"."sourceUrl" = modsourcesource.url)
                             Rows Removed by Join Filter: 2
                             Buffers: shared hit=44
                             ->  Index Scan using "ModSource_pkey" on "ModSource" "ModSource_1"  (cost=0.28..8.30 rows=1 width=46) (actual time=0.003..0.003 rows=1 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=33
                             ->  Seq Scan on "Source" modsourcesource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.001..0.001 rows=3 loops=11)
                                   Buffers: shared hit=11
         SubPlan 2
           ->  Aggregate  (cost=9.52..9.53 rows=1 width=32) (actual time=0.004..0.004 rows=1 loops=11)
                 Buffers: shared hit=28
                 ->  Unique  (cost=0.28..9.50 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                       Buffers: shared hit=28
                       ->  Nested Loop Left Join  (cost=0.28..9.50 rows=1 width=128) (actual time=0.002..0.002 rows=0 loops=11)
                             Join Filter: ("ModInstaller_1"."sourceUrl" = modinstallersource.url)
                             Rows Removed by Join Filter: 1
                             Buffers: shared hit=28
                             ->  Index Scan using "ModInstaller_pkey" on "ModInstaller" "ModInstaller_1"  (cost=0.28..8.29 rows=1 width=64) (actual time=0.001..0.001 rows=0 loops=11)
                                   Index Cond: ("modId" = "Mod".id)
                                   Buffers: shared hit=25
                             ->  Seq Scan on "Source" modinstallersource  (cost=0.00..1.09 rows=9 width=96) (actual time=0.000..0.000 rows=3 loops=3)
                                   Buffers: shared hit=3
 Planning Time: 7.720 ms
 Execution Time: 117.977 ms
(119 rows)