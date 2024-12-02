-- Q1) Who is the senior most employee based on job title? 
SELECT TOP 1 * 
FROM employee
ORDER BY levels DESC;
-- A1) Madan Mohan (Senior General Manager)

-- Q2) Which countries have the most invoices?
select top 1 COUNT(*)as c, billing_country 
 from invoice
 GROUP by billing_country
 order by c desc
 -- A2) USA (131)

 -- Q3) What are top 3 values of total invoices?
 select top 3 total from invoice
 order by total DESC
-- A3) 23.759999999999998,19.8,19.8

-- Q4) Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
select top 1 SUM(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc
-- A4) Prague (273.23999999999995)

-- Q5) Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.
SELECT top 1
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    SUM(invoice.total) AS total
FROM customer
JOIN invoice 
    ON customer.customer_id = invoice.customer_id
GROUP BY 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name
ORDER BY 
    total DESC;
-- A5) František Wichterlová (144.54000000000002)

-- Q6) Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A.
SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;
/* A6) aaronmitchell@yahoo.ca	Aaron	Mitchell
alero@uol.com.br	Alexandre	Rocha
astrid.gruber@apple.at	Astrid	Gruber
bjorn.hansen@yahoo.no	Bjørn	Hansen
camille.bernard@yahoo.fr	Camille	Bernard
daan_peeters@apple.be	Daan	Peeters
diego.gutierrez@yahoo.ar	Diego	Gutiérrez
dmiller@comcast.com	Dan	Miller
dominiquelefebvre@gmail.com	Dominique	Lefebvre
edfrancis@yachoo.ca	Edward	Francis
eduardo@woodstock.com.br	Eduardo	Martins
ellie.sullivan@shaw.ca	Ellie	Sullivan
emma_jones@hotmail.com	Emma	Jones
enrique_munoz@yahoo.es	Enrique	Muñoz
fernadaramos4@uol.com.br	Fernanda	Ramos
fharris@google.com	Frank	Harris
fralston@gmail.com	Frank	Ralston
frantisekw@jetbrains.com	František	Wichterlová
ftremblay@gmail.com	François	Tremblay
fzimmermann@yahoo.de	Fynn	Zimmermann
hannah.schneider@yahoo.de	Hannah	Schneider
hholy@gmail.com	Helena	Holý
hleacock@gmail.com	Heather	Leacock
hughoreilly@apple.ie	Hugh	O'Reilly
isabelle_mercier@apple.fr	Isabelle	Mercier
jacksmith@microsoft.com	Jack	Smith
jenniferp@rogers.ca	Jennifer	Peterson
jfernandes@yahoo.pt	João	Fernandes
joakim.johansson@yahoo.se	Joakim	Johansson
johavanderberg@yahoo.nl	Johannes	Van der Berg
johngordon22@yahoo.com	John	Gordon
jubarnett@gmail.com	Julia	Barnett
kachase@hotmail.com	Kathy	Chase
kara.nielsen@jubii.dk	Kara	Nielsen
ladislav_kovacs@apple.hu	Ladislav	Kovács
leonekohler@surfeu.de	Leonie	Köhler
lucas.mancini@yahoo.it	Lucas	Mancini
luisg@embraer.com.br	Luís	Gonçalves
luisrojas@yahoo.cl	Luis	Rojas
manoj.pareek@rediff.com	Manoj	Pareek
marc.dubois@hotmail.com	Marc	Dubois
mark.taylor@yahoo.au	Mark	Taylor
marthasilk@gmail.com	Martha	Silk
masampaio@sapo.pt	Madalena	Sampaio
michelleb@aol.com	Michelle	Brooks
mphilips12@shaw.ca	Mark	Philips
nschroder@surfeu.de	Niklas	Schröder
patrick.gray@aol.com	Patrick	Gray
phil.hughes@gmail.com	Phil	Hughes
ricunningham@hotmail.com	Richard	Cunningham
rishabh_mishra@yahoo.in	Rishabh	Mishra
robbrown@shaw.ca	Robert	Brown
roberto.almeida@riotur.gov.br	Roberto	Almeida
stanisław.wójcik@wp.pl	Stanisław	Wójcik
steve.murray@yahoo.uk	Steve	Murray
terhi.hamalainen@apple.fi	Terhi	Hämäläinen
tgoyer@apple.com	Tim	Goyer
vstevens@yahoo.com	Victor	Stevens
wyatt.girard@yahoo.fr	Wyatt	Girard */

-- Q7) Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands.
SELECT top 10 artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id,artist.name
ORDER BY number_of_songs DESC
/* A7) 22	Led Zeppelin	114
150	U2	112
58	Deep Purple	92
90	Iron Maiden	81
118	Pearl Jam	54
152	Van Halen	52
51	Queen	45
142	The Rolling Stones	41
76	Creedence Clearwater Revival	40
52	Kiss	35 */

-- Q8) Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC
/* A8) Occupation / Precipice	5286953
Through a Looking Glass	5088838
Greetings from Earth, Pt. 1	2960293
The Man With Nine Lives	2956998
Battlestar Galactica, Pt. 2	2956081
Battlestar Galactica, Pt. 1	2952702
Murder On the Rising Star	2935894
Battlestar Galactica, Pt. 3	2927802
Take the Celestra	2927677
Fire In Space	2926593
The Long Patrol	2925008
The Magnificent Warriors	2924716
The Living Legend, Pt. 1	2924507
The Gun On Ice Planet Zero, Pt. 2	2924341
The Hand of God	2924007
Experiment In Terra	2923548
War of the Gods, Pt. 2	2923381
The Living Legend, Pt. 2	2923298
War of the Gods, Pt. 1	2922630
Lost Planet of the Gods, Pt. 1	2922547
Baltar's Escape	2922088
The Lost Warrior	2920045
Lost Planet of the Gods, Pt. 2	2914664
The Gun On Ice Planet Zero, Pt. 1	2907615
Greetings from Earth, Pt. 2	2903778
Crossroads, Pt. 2	2869953
The Young Lords	2863571
Dave	2825166
"?"	2782333
Maternity Leave	2780416
Three Minutes	2763666
Hero	2713755
One of Them	2698791
How to Stop an Exploding Man	2687103
The Long Con	2679583
Live Together, Die Alone, Pt. 2	2656531
S.O.S.	2639541
One of Us	2638096
The Man from Tallahassee	2637637
The Cost of Living	2637500
The Glass Ballerina	2637458
Every Man for Himself	2637387
Not In Portland	2637345
Not In Portland	2637303
A Tale of Two Cities	2636970
Flashes Before Your Eyes	2636636
Stranger In a Strange Land	2636428
Left Behind	2635343
Tricia Tanaka Is Dead	2635010
Lost Survival Guide	2632590
The Moth	2631327
Torn	2631291
Par Avion	2629879
Enter 77	2629796
Dirty Hands	2627961
I Do	2627791
Tabula Rasa	2627105
Collaborators	2626626
The Woman King	2626376
Rapture	2624541
Taking a Break from All Your Worries	2624207
The Passage	2623875
Crossroads, Pt. 1	2622622
Maelstrom	2622372
Battlestar Galactica: The Story So Far	2622250
Unfinished Business	2622038
The Son Also Rises	2621830
Exodus, Pt. 1	2621708
Exodus (Part 1)	2620747
A Day In the Life	2620245
Outlaws	2619887
Exodus (Part 3) [Season Finale]	2619869
Hearts and Minds	2619462
The Eye of Jupiter	2618750
Born to Run	2618619
Special	2618530
Do No Harm	2618487
Exodus, Pt. 2	2618000
The Greater Good	2617784
The Brig	2617325
Greatest Hits	2617117
Through the Looking Glass, Pt. 2	2617117
Whatever the Case May Be	2616410
D.O.C.	2616032
The Man Behind the Curtain	2615990
Confidence Man	2615244
Seven Minutes to Midnight	2613988
Solitary	2612894
Something Nice Back Home	2612779
Man of Science, Man of Faith (Premiere)	2612250
Cabin Fever	2612028
Meet Kevin Johnson	2612028
Confirmed Dead	2611986
Genesis	2611986
The Beginning of the End	2611903
The Constant	2611569
The Hunting Party	2611333
Two for the Road	2610958
Through the Looking Glass, Pt. 1	2610860
The Other 48 Days	2610625
The 23rd Psalm	2610416
Lockdown	2610250
What Kate Did	2610250
The Whole Truth	2610125
Numbers	2609772
There's No Place Like Home, Pt. 1	2609526
Everybody Hates Hugo	2609192
Orientation	2609083
The Economist	2609025
Eggtown	2608817
One Giant Leap	2607649
Nothing to Hide	2605647
Exodus (Part 2) [Season Finale]	2605557
Collision	2605480
The Other Woman	2605021
...In Translation	2604575
Six Months Ago	2602852
Parasite	2602727
Run!	2602602
Homecoming	2601351
Company Man	2601226
Company Man	2601101
The Hard Part	2601017
Landslide	2600725
Fire + Water	2600333
The Fix	2600266
Unexpected	2598139
Fallout	2594761
Expos�	2593760
The Shape of Things to Come	2591299
Raised By Another	2590459
Distractions	2590382
House of the Rising Sun	2590032
Ji Yeon	2588797
Five Years Gone	2587712
Walkabout	2587370
Abandoned	2587041
0.07%	2585794
There's No Place Like Home, Pt. 3	2582957
Deus Ex Machina	2582009
Better Halves	2573031
White Rabbit	2571965
Don't Look Back	2571154
Adrift	2564958
Collision	2564916
Further Instructions	2563980
A Measure of Salvation	2563938
...And Found	2563833
Catch-22	2561394
All the Best Cowboys Have Daddy Issues	2555492
Lost (Pilot, Part 1) [premiere]	2548875
The Job	2541875
Hiros	2533575
A Benihana Christmas, Pts. 1 & 2	2519436
Homecoming	2515882
There's No Place Like Home, Pt. 2	2497956
Past, Present, and Future	2492867
Pilot	2484567
Live Together, Die Alone, Pt. 1	2478041
Lost (Pilot, Part 2)	2436583
Branch Closing	1822781
Branch Closing	1814855
The Merger	1801926
The Negotiation	1767851
Women's Appreciation	1732649
Casino Night - Season Finale	1712791
The Return	1705080
Producer's Cut: The Return	1700241
Beach Games	1676134
Dazed And Confused	1612329
The Office: An American Workplace (Pilot)	1380833
Email Surveillance	1328870
Gay Witch Hunt	1326534
Hot Girl	1325458
Basketball	1323541
Health Care	1321791
The Fight	1320028
The Alliance	1317125
Halloween	1315333
Diversity Day	1306416
Business School	1302093
The Client	1299341
The Convention	1297213
Sexual Harassment	1294541
Performance Review	1292458
Office Olympics	1290458
Traveling Salesmen	1289039
The Fire	1288166
Grief Counseling	1282615
Christmas Party	1282115
The Initiation	1280113
Diwali	1279904
Drug Testing	1278625
Boys and Girls	1278333
Dwight's Speech	1278041
The Coup	1276526
The Injury	1275275
Conflict Resolution	1274583
The Convict	1273064
Cocktails	1272522
Ben Franklin	1271938
Back from Vacation	1271688
Phyllis's Wedding	1271521
Safety Training	1271229
Valentine's Day	1270375
Take Your Daughter to Work Day	1268333
Product Recall	1268268
Booze Cruise	1267958
The Secret	1264875
The Carpet	1264375
The Dundies	1253541
Michael's Birthday	1237791
Space Truckin'	1196094
Dazed And Confused	1116734
We've Got To Get Together/Jingo	1070027
Funky Piano	934791
Going Down / Highway Star	913658
My Funny Valentine (Live)	907520
Santana Jam	882834
The Sun Road	880640
Whole Lotta Love	863895
Mistreated (Alternate Version)	854700
Just Ain't Good Enough	850259
Miles Runs The Voodoo Down	843964
Whole Lotta Love (Medley)	825103
Rime of the Ancient Mariner	816509
Walkin'	807392
You Fool No One	804101
Rime Of The Ancient Mariner	789472
Moby Dick	766354
You Fool No One (Alternate Version)	763924
Mistreated	758648
No Quarter	749897
The Calling	747755
El Corazon Manda	713534
How Many More Times	711836
The End	701831
Sign Of The Cross	678008
Advance Romance	677694
Reach Down	672773
Mercyful Fate	671712
Xanadu	667428
In My Time Of Dying	666017
I Heard It Through The Grapevine	664894
Amy Amy Amy (Outro)	663426
Outbreak	659226
Stairway To Heaven	657293
Sign Of The Cross	649116
Sleeping Village	644571
Fried Neckbones And Home Fries	638563
Carouselambra	634435
La Puesta Del Sol	628062
Achilles Last Stand	625502
Child In Time	620460
You Shook Me(2)	619467
The Way You Do To Mer	618344
Smoke On The Water	618031
Revolution 1993	616829
Coma	616511
Child In Time (Son Of Aleric - Instrumental)	602880
Adagio for Strings from the String Quartet, Op. 11	596519
Seventh Son of a Seventh Son	593580
Jingo	592953
The Angel And The Gambler	592744
All I Want Is You	591986
Talkin' 'Bout Women Obviously	589531
The Outlaw Torn	588721
To Live Is To Die	588564
...And Justice For All	585769
Book of Hours	583366
Stratus	582086
The Messiah: Behold, I Tell You a Mystery... The Trumpet Shall Sound	582029
Dream Of Mirrors	578324
La Villa Strangiato	577488
Blind Curve: Vocal Under A Bloodlight / Passing Strangers / Mylo / Perimeter Walk / Threshold	569704
Symphony No. 3 Op. 36 for Orchestra and Soprano "Symfonia Piesni Zalosnych" \ Lento E Largo - Tranquillissimo	567494
Tea For One	566752
For the Greater Good of God	564893
So What	564009
Estranged	563800
The Legacy	562966
Symphonie Fantastique, Op. 14: V. Songe d'une nuit du sabbat	561967
Dream Of Mirrors	561162
Concerto for Piano No. 2 in F Minor, Op. 21: II. Larghetto	560342
The Clansman	559203
Homecoming / The Death Of St. Jimmy / East 12th St. / Nobody Likes You / Rock And Roll Girlfriend / We're Coming Home Again	558602
No More Tears	555075
Iron Man/Children of the Grave	552308
Falling in Circles	549093
Jesus Of Suburbia / City Of The Damned / I Don't Care / Dearly Beloved / Tales Of Another Broken Home	548336
The Nomad	546115
Release	546063
Tuesday's Gone	545750
Scheherazade, Op. 35: I. The Sea and Sindbad's Ship	545203
Someday My Prince Will Come	544078
Faroeste Caboclo	543007
The Clansman	539689
November Rain	537540
The Call Of Ktulu	534883
Chaos-Control	529841
Just Another Story	529684
Stairway To Heaven	529658
Riviera Paradise	528692
She Wears Black	528666
All Within My Hands	527986
In The Light	526785
On the Beautiful Blue Danube	526696
Black Light Syndrome	526471
Brighter Than a Thousand Suns	526255
Whistle Stop	526132
Locomotive	522396
Jupiter, the Bringer of Jollity	522099
By-Tor And The Snow Dog	519888
A E O Z	518556
Dance Of Death	516649
Alexander the Great	515631
War Pigs	515435
Master Of Puppets	515239
Year to the Day	514612
Won't Get Fooled Again (Full Length Version)	513750
Dark Corners	513541
Blow Your Mind	512339
Invisible Kid	510197
The Alchemist	509413
Kashmir	508604
Paschendale	508107
How Many More Times	508055
The Thin Line Between Love & Hate	506801
Where The River Goes	505991
Rain Song	505808
Some Kind Of Monster	505626
Title Song	505521
Miserere mei, Deus	501503
Fools	500427
Orion	500062
Bleeding Me	497998
LOST In 8:15	497163
Disposable Heroes	496718
Sir Psycho Sexy	496692
Fixxxer	496065
Iron Maiden	494602
Wheels Of Confusion / The Straightener	494524
Book Of Thel	494393
The Real Thing	493635
Concerto for Violin, Strings and Continuo in G Major, Op. 3, No. 9: I. Allegro	493573
You Oughta Know (Alternate)	491885
The Unbeliever	490422
Petits Machins (Little Stuff)	487392
Steal Away (The Night)	485720
Don't Look To The Eyes Of A Stranger	483657
Concerto for Cello and Orchestra in E minor, Op. 85: I. Adagio - Moderato	483133
Terra	482429
Stairway To Heaven	481619
Out Of Control	479242
Flight Of The Rat	478302
The Evil That Men Do	478145
Bye Bye Blackbird	476003
Evil Ways	475402
Running Free	474017
Nefertiti	473495
Aeroplane Flies High	473391
Old Love	472920
Loverman	472764
Hallowed Be Thy Name	471849
Am I Evil?	470256
Come Back	469968
The Longest Day	467810
Suicide Solution (With Guitar Solo)	467069
War Pigs	464770
Smoke On The Water	464378
The Frayed Ends Of Sanity	464039
Once	462837
Civil War	461165
Us And Them	461035
Fear Of The Dark	460695
Wiser Time	459990
The Rain Song	459180
Low Man's Lyric	457639
Snoopy's search-Red baron	456071
Powerslave	454974
Burn	453955
Pa�s Tropical	452519
Sometimes I Feel Like Screaming	451840
Hallowed Be Thy Name	451422
Heaven Can Wait	448574
Hallowed Be Thy Name	447791
Duende	447582
One	446484
Caught Somewhere in Time	445779
To Tame A Land	445283
Lord of Light	444614
No More Tears	444358
Since I've Been Loving You	444055
Hallowed Be Thy Name	443977
Fortunes Of War	443977
The Reincarnation of Benjamin Breeg	442106
Lazy	442096
No More Lies	441782
Heaven Can Wait	441417
St. Anger	441234
Phantom Of The Opera	441155
Heaven Can Wait	440555
River Song	439510
Leave	437968
Fear Of The Dark	436976
Sozinho (Hitmakers Classic Mix)	436636
Master Of Puppets	436453
Blood Brothers	435513
Blood Brothers	434442
Stone Crazy	433397
The Four Horsemen	433188
Fear Of The Dark	431542
Fear Of The Dark	431333
Hallowed Be Thy Name (Live) [Non Album Bonus Track]	431262
Hard Lovin' Man	431203
Victim Of Change (Live)	430942
Layla	430733
Shoot Me Again	430210
The Unnamed Feeling	429479
Hallowed Be Thy Name	428669
Inside Job	428643
Light My Fire	428329
05 - Phantom of the Opera	428016
When The Levee Breaks	427702
Journeyman	427023
Time	425195
Breakdown	424960
Knocking At Your Back Door	424829
Otay	423653
Scam	422321
Voce Nao Entende Nada - Cotidiano	421982
A Bencao E Outros	421093
No Quarter	420493
Snowblind	420022
Lemon	418324
Rehab (Hot Chip Remix)	418293
Phantom Of The Opera	418168
Afraid To Shoot Strangers	416496
Since I've Been Loving You	416365
Seek & Destroy	415817
Black	415712
No No No	414902
Fade To Black	414824
Four Walled World	414474
Where The Wild Things Are	414380
Norwegian Wood	413910
Afraid To Shoot Strangers	412525
These Colours Don't Run	412152
Wellington's Victory or the Battle Symphony, Op.91: 2. Symphony of Triumph	412000
In The Evening	410566
Se Liga	410409
Ghost Of The Navigator	410070
Samba Da B�n��o	409965
You Sent Me Flying / Cherry	409906
My Friend Of Misery	409547
Revelations	408607
Ghost Of The Navigator	408607
Down by the Sea	408163
Afraid To Shoot Strangers	407980
Powerslave	407823
Daughter	407484
Paradise City	406347
Karelia Suite, Op.11: 2. Ballade (Tempo Di Menuetto)	406000
Blue Train	405028
The Educated Fool	404767
Girl From A Pawnshop	404688
Third Stone From The Sun	404453
Computadores Fazem Arte	404323
Wherever I May Roam	404323
The Small Hours	403435
Blackened	403382
Jerusalem	402390
Dazed and Confused	401920
Babe I'm Gonna Leave You	401475
Terra	401319
Soot & Stars	399986
The Edge Of Darkness	399333
The House Jack Built	398942
Jizzlobber	398341
Helpless	398315
Thank You	398262
Still Of The Night	398210
Ride The Lightning	397740
Astronomy	397531
Creeping Death	396878
Deep Waters	396460
Save Me (Remix)	396303
The Thing That Should Not Be	396199
King For A Day	395859
22 Acacia Avenue	395572
The Unforgiven II	395520
The Shortest Straw	395389
Concerto for Clarinet in A Major, K. 622: II. Adagio	394482
Wicked Ways	393691 */

-- Q9) Find how much amount spent by each customer on the best selling artist? Write a query to return customer name, artist name and total spent.
WITH best_selling_artist AS (
	SELECT top 1 artist.artist_id AS artist_id, artist.name AS artist_name, 
    SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY artist.artist_id,artist.name 
	ORDER BY 3 DESC
	)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY 5 DESC;

/*  A9) 46	Hugh	O'Reilly	Queen	27.719999999999985
38	Niklas	Schröder	Queen	18.81
3	François	Tremblay	Queen	17.82
34	João	Fernandes	Queen	16.830000000000002
41	Marc	Dubois	Queen	11.88
53	Phil	Hughes	Queen	11.88
47	Lucas	Mancini	Queen	10.89
33	Ellie	Sullivan	Queen	10.89
5	František	Wichterlová	Queen	3.96
20	Dan	Miller	Queen	3.96
23	John	Gordon	Queen	2.9699999999999998
31	Martha	Silk	Queen	2.9699999999999998
54	Steve	Murray	Queen	2.9699999999999998
57	Luis	Rojas	Queen	1.98
1	Luís	Gonçalves	Queen	1.98
35	Madalena	Sampaio	Queen	1.98
36	Hannah	Schneider	Queen	1.98
42	Wyatt	Girard	Queen	1.98
52	Emma	Jones	Queen	1.98
44	Terhi	Hämäläinen	Queen	1.98
48	Johannes	Van der Berg	Queen	1.98
49	Stanisław	Wójcik	Queen	1.98
24	Frank	Ralston	Queen	1.98
28	Julia	Barnett	Queen	1.98
30	Edward	Francis	Queen	1.98
8	Daan	Peeters	Queen	1.98
11	Alexandre	Rocha	Queen	1.98
15	Jennifer	Peterson	Queen	1.98
16	Frank	Harris	Queen	1.98
17	Jack	Smith	Queen	1.98
19	Tim	Goyer	Queen	0.99
13	Fernanda	Ramos	Queen	0.99
6	Helena	Holý	Queen	0.99
22	Heather	Leacock	Queen	0.99
26	Richard	Cunningham	Queen	0.99
27	Patrick	Gray	Queen	0.99
50	Enrique	Muñoz	Queen	0.99
45	Ladislav	Kovács	Queen	0.99
43	Isabelle	Mercier	Queen	0.99
39	Camille	Bernard	Queen	0.99
58	Manoj	Pareek	Queen	0.99
59	Rishabh	Mishra	Queen	0.99
55	Mark	Taylor	Queen	0.99 */

-- Q10) We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.
WITH popular_genre AS 
(
    SELECT 
        COUNT(invoice_line.quantity) AS purchases, 
        customer.country, 
        genre.name, 
        genre.genre_id, 
        ROW_NUMBER() OVER (
            PARTITION BY customer.country 
            ORDER BY COUNT(invoice_line.quantity) DESC
        ) AS RowNo
    FROM invoice_line 
    JOIN invoice 
        ON invoice.invoice_id = invoice_line.invoice_id
    JOIN customer 
        ON customer.customer_id = invoice.customer_id
    JOIN track 
        ON track.track_id = invoice_line.track_id
    JOIN genre 
        ON genre.genre_id = track.genre_id
    GROUP BY customer.country, genre.name, genre.genre_id
)
SELECT * 
FROM popular_genre 
WHERE RowNo <= 1;

/* A10) 17	Argentina	Alternative & Punk	4	1
34	Australia	Rock	1	1
40	Austria	Rock	1	1
26	Belgium	Rock	1	1
205	Brazil	Rock	1	1
333	Canada	Rock	1	1
61	Chile	Rock	1	1
143	Czech Republic	Rock	1	1
24	Denmark	Rock	1	1
46	Finland	Rock	1	1
211	France	Rock	1	1
194	Germany	Rock	1	1
44	Hungary	Rock	1	1
102	India	Rock	1	1
72	Ireland	Rock	1	1
35	Italy	Rock	1	1
33	Netherlands	Rock	1	1
40	Norway	Rock	1	1
40	Poland	Rock	1	1
108	Portugal	Rock	1	1
46	Spain	Rock	1	1
60	Sweden	Rock	1	1
166	United Kingdom	Rock	1	1
561	USA	Rock	1	1 */

-- Q11) Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount.
WITH Customer_with_country AS (
    SELECT 
        customer.customer_id,
        first_name,
        last_name,
        billing_country,
        SUM(total) AS total_spending,
        ROW_NUMBER() OVER (
            PARTITION BY billing_country 
            ORDER BY SUM(total) DESC
        ) AS RowNo
    FROM invoice
    JOIN customer ON customer.customer_id = invoice.customer_id
    GROUP BY customer.customer_id, first_name, last_name, billing_country
)
SELECT * 
FROM Customer_with_country 
WHERE RowNo = 1;

/* A11)56	Diego	Gutiérrez	Argentina	39.599999999999994	1
55	Mark	Taylor	Australia	81.18	1
7	Astrid	Gruber	Austria	69.3	1
8	Daan	Peeters	Belgium	60.38999999999999	1
1	Luís	Gonçalves	Brazil	108.89999999999998	1
3	François	Tremblay	Canada	99.99	1
57	Luis	Rojas	Chile	97.02	1
5	František	Wichterlová	Czech Republic	144.54000000000002	1
9	Kara	Nielsen	Denmark	37.61999999999999	1
44	Terhi	Hämäläinen	Finland	79.2	1
42	Wyatt	Girard	France	99.99	1
37	Fynn	Zimmermann	Germany	94.05	1
45	Ladislav	Kovács	Hungary	78.20999999999998	1
58	Manoj	Pareek	India	111.87	1
46	Hugh	O'Reilly	Ireland	114.84	1
47	Lucas	Mancini	Italy	50.49	1
48	Johannes	Van der Berg	Netherlands	65.34	1
4	Bjørn	Hansen	Norway	72.27	1
49	Stanisław	Wójcik	Poland	76.23	1
34	João	Fernandes	Portugal	102.96000000000001	1
50	Enrique	Muñoz	Spain	98.00999999999999	1
51	Joakim	Johansson	Sweden	75.24	1
53	Phil	Hughes	United Kingdom	98.01	1
17	Jack	Smith	USA	98.01	1 */ 