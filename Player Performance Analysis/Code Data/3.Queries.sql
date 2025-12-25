use Player_Performance_Analysis_DB;
select * from players;

-- 1. Top 10 Players by Average Rating
select concat(P.first_name," ",P.last_name) as Name,
T.team_name as Team,
round(avg(PP.rating),2) as Rating from Players P
join PlayerPerformance PP on P.player_id = PP.player_id
join PlayerContracts PC on P.player_id = PC.player_id
join Teams T on PC.team_id = T.team_id 
group by PP.player_id,T.team_name order by Rating desc limit 10;

-- 2. Top 10 Player based on Goals + Assists
select concat(P.first_name," ",P.last_name) as Player,
T.team_name as Team, 
sum(PP.goals) as goals ,
sum(PP.assists) as assists,
sum(goals) + sum(assists) as Performance 
from PlayerPerformance PP
join Players P on P.player_id = PP.player_id
join PlayerContracts PC on P.player_id = PC.player_id
join Teams T on PC.team_id = T.team_id 
group by P.player_id,T.team_name order by Performance desc,goals desc limit 10;

-- 3. Most Valuable Player per position
select Id,rank_pos,player, position, market_value
from ( select player_id as Id,CONCAT(first_name, ' ', last_name) AS player, position, market_value,
dense_rank() over (partition by position order by market_value desc) as rank_pos from Players ) as ranked
where rank_pos = 1
order by market_value desc;

-- 4.Team Effectiveness

select t.team_name,
sum(pp.goals) as goals_scored,
sum(pp.shots) as total_shots,
round(sum(pp.goals)/sum(pp.shots)*100, 1) as conversion_rate
from PlayerPerformance pp
join PlayerContracts pc on pp.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
group by t.team_id
order by conversion_rate desc;

-- 5. Injury report by team
select t.team_name,
concat(p.first_name, ' ', p.last_name) as player,
pf.injury_type,
pf.injury_severity,
datediff( pf.expected_recovery_date,curdate()) as days_until_recovery
from PlayerFitness pf
join Players p on pf.player_id = p.player_id
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
where pf.injury_status != 'Fit'
order by days_until_recovery;

SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));


-- 6. Salary Vs Performance Analysis
select concat(p.first_name, ' ', p.last_name) as player, t.team_name,
pc.salary as weekly_salary,
round(avg(pp.rating), 1) as avg_rating,
round(pc.salary / avg(pp.rating), 0) as cost_per_rating_point
from PlayerContracts pc
join Players p on pc.player_id = p.player_id
join PlayerPerformance pp on p.player_id = pp.player_id
join Teams t on pc.team_id = t.team_id
group by p.player_id, t.team_name, pc.salary
having count(pp.match_id) > 0
order by cost_per_rating_point desc;

-- 7. Top Denfenders
select 
    concat(p.first_name, ' ', p.last_name) as player,
    t.team_name,
    sum(pp.tackles) as tackles,
    round(avg(pp.pass_accuracy), 1) as pass_accuracy
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
where p.position = 'Defender'
group by p.player_id
order by tackles desc
limit 10;

-- 8. Match Summary
select m.match_date , ht.team_name as home_team , at.team_name as away_team,
m.home_score , m.away_score,
case
when m.home_score > m.away_score then ht.team_name
when m.away_score > m.home_score then at.team_name
else 'Draw'
end as winner
from Matches m
join Teams ht on m.home_team_id = ht.team_id
join Teams at on m.away_team_id = at.team_id;

-- 9. Player Discipline Report
select 
    t.team_name,
    concat(p.first_name, ' ', p.last_name) as player,
    sum(pp.yellow_cards) as yellows,
    sum(pp.red_cards) as reds
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
group by p.player_id
having (yellows + reds) > 0
order by (yellows + reds) desc;

-- 10. GoalKeeper Analysis
select concat(p.first_name, ' ', p.last_name) as goalkeeper , t.team_name , count(distinct m.match_id) as matches,
round(avg(pp.rating), 1) as avg_rating , sum(m.home_score + m.away_score) as goals_conceded
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
join Matches m on pp.match_id = m.match_id
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
where p.position = 'Goalkeeper'
group by p.player_id
order by avg_rating desc , goals_conceded desc;

-- 11. Team Result Analysis
select team_name,
sum(case when result = 'Win' then 1 else 0 end) as wins,
sum(case when result = 'Draw' then 1 else 0 end) as draws,
sum(case when result = 'Loss' then 1 else 0 end) as losses
from ( select ht.team_name,
case 
when m.home_score > m.away_score then 'Win'
when m.home_score < m.away_score then 'Loss'
else 'Draw'
end as result
from Matches m
join Teams ht ON m.home_team_id = ht.team_id
union all
select at.team_name,
case 
when m.away_score > m.home_score then 'Win'
when m.away_score < m.home_score then 'Loss'
else 'Draw'
end as result
from Matches m
join Teams at on m.away_team_id = at.team_id) as team_results
group by team_name
order by wins desc;

-- 12. Team Squad Analysis
select t.team_name,
count(distinct p.player_id) as squad_size,
GROUP_CONCAT(DISTINCT p.position separator ', ') as positions_covered,
avg(p.market_value) as avg_market_value
from Players p
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
group by t.team_id
order by squad_size desc;

-- 13. Young Talent
select concat(p.first_name, ' ', p.last_name) as player, t.team_name,
timestampdiff(year, p.date_of_birth, curdate()) as age,
round(avg(pp.rating), 1) as avg_rating,
sum(pp.goals + pp.assists) as goal_contributions
from Players p
join PlayerPerformance pp on p.player_id = pp.player_id
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
where p.date_of_birth > date_sub(curdate(), interval 25 year)
group by p.player_id
having count(pp.match_id) > 0
order by avg_rating desc , goal_contributions desc
limit 10;

-- 14. Home Advantage
SELECT 
player,
home_avg,
away_avg,
home_avg - away_avg AS home_advantage
FROM (
select concat(p.first_name, ' ', p.last_name) AS player,
round(avg(case when m.home_team_id = pc.team_id then pp.rating end), 1) as home_avg,
round(avg(case when m.away_team_id = pc.team_id then pp.rating end), 1) as away_avg
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
join Matches m on pp.match_id = m.match_id
join PlayerContracts pc on p.player_id = pc.player_id
group by p.player_id
having count(distinct case when m.home_team_id = pc.team_id then pp.match_id end) > 0
and count(distinct case when m.away_team_id = pc.team_id then pp.match_id end) > 0) as home_away
order by home_advantage desc
limit 10;

-- 15. Active Years of Teams
select 
team_name,
founded_year,
timestampdiff(year, concat(founded_year, '-01-01'), curdate()) as years_active
from Teams 
order by years_active desc;

-- 16. average player rating by teams
select t.team_name, ROUND(avg(pp.rating), 1) as avg_rating
from PlayerPerformance pp
join PlayerContracts pc on pp.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
group by t.team_name
order by avg_rating desc;

-- 17. players count by nationality
select nationality, count(*) as player_count
from Players
group by nationality
order by player_count desc;

-- 18. GoalKeepers cleansheet
select concat(p.first_name, ' ', p.last_name) as goalkeeper,
t.team_name,
count(*) as clean_sheets
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
join Matches m on pp.match_id = m.match_id
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
where p.position = 'Goalkeeper'
and ((m.home_team_id = t.team_id and m.away_score = 0)
or (m.away_team_id = t.team_id and m.home_score = 0))
group by goalkeeper
order by clean_sheets desc;

-- 19. Teams with most goals conceded
select t.team_name, sum(case 
when m.home_team_id = t.team_id then m.away_score 
else m.home_score end) as goals_conceded
from Matches m
join Teams t on t.team_id in (m.home_team_id, m.away_team_id)
group by t.team_name
order by goals_conceded desc;

-- 20. Players with highest pass accuracy
select concat(first_name, ' ', last_name) as player,
round(avg(pass_accuracy), 1) as avg_pass_accuracy
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
where passes > 20
group by player
order by avg_pass_accuracy desc
limit 10;

-- 21. High scoring Matches
select m.match_date, 
ht.team_name as home_team, 
at.team_name as away_team,
m.home_score + m.away_score as total_goals
from Matches m
join Teams ht on m.home_team_id = ht.team_id
join Teams at on m.away_team_id = at.team_id
order by total_goals desc
limit 5;

-- 22. Average goals per match
SELECT ROUND(AVG(home_score + away_score), 1) AS avg_goals_per_match
FROM Matches;

-- 23. Teams Conceding most Yellow cards
select t.team_name, SUM(pp.yellow_cards) AS yellow_cards
from PlayerPerformance pp
join PlayerContracts pc on pp.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
group by t.team_name
order by yellow_cards desc;

-- 24. Average Player Age By teams
select t.team_name, 
round(avg(timestampdiff(year, p.date_of_birth, CURDATE())), 1) as avg_age
from Players p
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
group by t.team_name
order by avg_age;

-- 25. Players who scored in their last match
select concat(p.first_name, ' ', p.last_name) as player,
max(m.match_date) as last_match_date
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
join Matches m on pp.match_id = m.match_id
where pp.goals > 0
group by player;

-- 26. Players with Most Man of the Match (High Ratings)
select concat(first_name, ' ', last_name) as player,
count(*) as high_rating_games
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
where rating >= 8.5
group by player
order by high_rating_games desc
limit 10;

-- 27. Players who never scored
select concat(first_name, ' ', last_name) as player
from Players p
where not exists (
select 1 from PlayerPerformance pp 
where pp.player_id = p.player_id and goals > 0);

-- 28. average goals per competition
select c.competition_name,
round(avg(home_score + away_score), 1) as avg_goals
from Matches m
join Competitions c on m.competition_id = c.competition_id
group by c.competition_name
order by avg_goals desc;

-- 29. Wins by Goal Margins
select abs(home_score - away_score) as goal_margin,
count(*) as matches
from Matches
where  home_score != away_score
group by goal_margin
order by matches desc;

-- 30.Players involved in most goals
select concat(p.first_name, ' ', p.last_name) as player,
t.team_name,
sum(pp.goals) as goals,
sum(pp.assists) as assists,
sum(pp.goals) + sum(pp.assists) as total_involvement,
round((sum(pp.goals) + sum(pp.assists)) / count(distinct pp.match_id), 1) as per_match
from PlayerPerformance pp
join Players p on pp.player_id = p.player_id
join PlayerContracts pc on p.player_id = pc.player_id
join Teams t on pc.team_id = t.team_id
group by player
having count(distinct pp.match_id) > 0
order by total_involvement desc
limit 10;