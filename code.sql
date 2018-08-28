with funnels as (
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
   
select number_of_pairs as 'try-ons', 
	count(distinct(user_id)) as quiz_takers,
  sum(is_purchase) as 'purchases',
  1.0 * sum(is_purchase)/count(*) as 'purchase_rate'
from funnels
group by number_of_pairs;
                 
select style, count(*) as responses
from quiz
group by style 
order by responses desc;
                 
select fit, count(*) as responses
from quiz
group by fit
order by responses desc;
                 
select shape, count(*) as responses
from quiz
group by shape 
order by responses desc;
                 
select color, count(*) as responses
from quiz
group by color 
order by responses desc;

--select 1.0 * sum(is_home_try_on)/count(*) as 'home_try_on_rate'
--from funnels;
/*sum(is_home_try_on) as 'home_try_on',
count(*) where h.number_of_pairs = '3 pairs' as '3_pair_count',
count(*) where h.number_of_pairs = '5 pairs' as '5_pair_count',   
count(*) where h.number_of_pairs = '3 pairs' and is_purchase = 1 as '3_pair_purchase',
count(*) where h.number_of_pairs = '5 pairs' and is_purchase = 1 as '5_pair_purchase',
1.0 * sum('3_pair_purchase')/sum('3_pair_count')
from funnels*/
