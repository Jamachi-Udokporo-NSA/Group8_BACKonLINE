DROP TABLE IF EXISTS 'UserAnswer';
DROP TABLE IF EXISTS 'Survey';
DROP TABLE IF EXISTS 'staff';
DROP TABLE IF EXISTS 'Question';
DROP TABLE IF EXISTS 'Patient';
DROP TABLE IF EXISTS 'Answer';

CREATE TABLE IF NOT EXISTS `UserAnswer` (
	`UserAnswerID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`AnswerID`	INTEGER NOT NULL,
	`AnswerScore`	INTEGER NOT NULL,
	`SurveyID`	INTEGER NOT NULL,
	`AnswerText`	TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `Survey` (
	`SurveyID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Date`	TEXT NOT NULL,
	`TotalScore`	INTEGER NOT NULL,
	`PatientID`	INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS `Staff` (
	`StaffID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Email`	TEXT NOT NULL,
	`Password`	TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Question` (
	`QuestionID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`QuestionText`TEXT NOT NULL,
	'QuestionType'TEXT NOT NULL,
	'QuestionGroup'TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Patient` (
	`PatientID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`FirstName`	TEXT NOT NULL,
	`SurName`	TEXT NOT NULL,
	`Email`	TEXT NOT NULL,
	`Password`	TEXT NOT NULL,
	`Age`	NUMERIC NOT NULL,
	`Gender`	TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `Answer` (
	`AnswerID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`AnswerText`	TEXT NOT NULL,
	`Score`	INTEGER NOT NULL,
	`QuestionID`	INTEGER NOT NULL
);

-- dummy data
INSERT INTO UserAnswer ('UserAnswerID', 'AnswerID', 'AnswerScore', 'SurveyID', 'AnswerText') VALUES (1,1,0,1,'Yes');
INSERT INTO UserAnswer ('UserAnswerID', 'AnswerID', 'AnswerScore', 'SurveyID', 'AnswerText') VALUES (2,4,1,2,'Car accident');
INSERT INTO UserAnswer ('UserAnswerID', 'AnswerID', 'AnswerScore', 'SurveyID', 'AnswerText') VALUES (3,13,0,3,'Yes, I was satisfied with the treatment');
INSERT INTO Survey ('SurveyID','Date', 'TotalScore', 'PatientID') VALUES (1,03/10/2010,0,1);
INSERT INTO Survey ('SurveyID','Date', 'TotalScore', 'PatientID') VALUES (2,23/03/2012,1,1);
INSERT INTO Survey ('SurveyID','Date', 'TotalScore', 'PatientID') VALUES (3,05/04/2015,0,1);
-- dummy data

INSERT INTO staff ('StaffID','Email','Password') VALUES (1,'Admin','Admin');

INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (1,'Do you know what caused your current back pain?','Single',1);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (2,'If yes, choose an option from the list below:','Single',1);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (3,'What do you think is wrong with your back?','Text', 1);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (4,'If you have been treated for back pain, were you satisfied with your treatment?','Single',2);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (5,'What medication do you take to manage your back pain?','Multiple',2);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (6,'How effective is the medication in reducing your back pain?','Single',2);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (7,'Where is your pain? Please tick all body areas that apply','SliderPlus',3);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (8,'Is your pain there all the time?', 'Single',4);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (9,'What type of pain is it? Please tick all options that apply', 'Multiple',4);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (10,'When is your pain at its worst?', 'Single',4);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (11,'Can you ease your back pain?','Single',5);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (12,'How do you ease your back pain? Please tick all options that apply','Multiple',5);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (13,'In general, is your back pain getting better, staying the same or getting worse?','Single',6);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (14,'From the list below, please tick all the activities that make your pain worse ','Multiple',6);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (15,'From the list below, please tick all the activities that stop or decrease your pain.','Multiple',6);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (16,'Is this the first time you have experienced this type of pain?','Single',7);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (17,'If you had a previous episode of back pain, what helped in making your pain better? Please tick all options that apply','Multiple',7);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (18,'Other than your back pain, do you experience other odd sensations in your back or legs (for example: crawling sensation, stinging, pressure) ','Single',8);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (19,'Please tick all the areas where you experience this feeling:', 'Multiple',8);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (20,'On average, how many hours do you sleep?','Slider',9);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (21,'Does your back pain wake you up every night?','Single',9);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (22,'If you wake up with back pain, can you get back to sleep?','Single',9);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (23,'how strongly do you agree with this statement : ‘I believe that my job caused /contributed to my back pain’','Single',10);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (24,'Do you feel supported by your boss and/or co-workers?','Single',11);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (25,'How is your back pain affecting your work?','Single',11);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (26,'Are you off work right now because of your back pain?','Single',12);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (27,'How long have you been off work?','Single',12);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (28,'How likely it is that you would return to work within six months?','Single',12);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (29,'‘I can’t do my normal daily activities because of my back pain’','Single',13);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (30,'‘My back pain is negatively affecting my social life’','Single',13);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (31,'‘My back pain is affecting my relationship with my significant other’','Single',13);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (32,'‘I don’t know what makes my back pain worse or what eases it ‘', 'Single',13);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (33,'‘My back pain makes me feel stressed/anxious’','Single',14);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (34,'‘Stress increases my back pain’','Single',14);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (35,'‘Physical activity increases my back pain’','Single',14);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (36,'‘Since my back pain started, I feel more tired’','Single',14);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (37,'‘I have lost interest and/or pleasure in doing things because of my back pain’','Single',15);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (38,'‘I don’t think my family and friends understand what I’m going through with my back pain.’', 'Single',15);
INSERT INTO Question ('QuestionID','QuestionText','QuestionType','QuestionGroup') VALUES (39,'‘I don’t think my back pain will ever go away.’','Single',15);

INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (1,'Yes',0,1);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (2,'No',2,1);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (3,'Not Sure ',1,1);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (4,'Car accident',1,2);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (5,'Sport Injury',0,2);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (6,'Lifting/Bending accident',0,2);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (7,'Falling Down',0,2);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (8,'Other trauma',0,2);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (9,'Work Related',1,2);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (10,'Other',0,2);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (11,'Nothing specific',1,2);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (12,'',0,3);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (13,'Yes, I was satisfied with the treatment',0,4);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (14,'I was neither satisfied nor dissatisfied with the treatment',1,4);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (15,'No, I was not satisfied with the treatment',2,4);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (16,'I was never treated for back pain',-1,4);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (17,'Paracetamol',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (18,'Ibuprofen',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (19,'Codeine',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (20,'Diazepam',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (21,'Amitriptyline',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (22,'Duloxetine/Cymbalta',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (23,'Gabapentin',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (24,'Tramadol',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (25,'Hydrocodone',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (26,'Cortisone',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (27,'Acetaminophen',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (28,'Glucosamine',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (29,'Valium',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (30,'Naproxen',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (31,'other',1,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (32,'I don’t take any medication for my back pain',0,5);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (33,'Effective',0,6);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (34,'Not Sure',1,6);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (35,'Ineffective',2,6);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (36,'Neck',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (37,'Right shoulder',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (38,'Left shoulder',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (39,'Right arm',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (40,'Left arm',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (41,'Upper back',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (42,'Lower back',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (43,'Right buttock',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (44,'Left buttock',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (45,'Right hip',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (46,'Left hip',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (47,'Right leg',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (48,'Left leg',1,7);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (49,'My pain is there all the time',2,8);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (50,'My pain comes and goes',0,8);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (51,'Not sure',1,8);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (52,'Deep',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (53,'Nagging',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (54,'Dull',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (55,'Sharp',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (56,'Shooting',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (57,'Dull ache',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (58,'Like lightning',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (59,'Burning',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (60,'Pressure',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (61,'Stinging',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (62,'Aching',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (63,'Throbbing',1,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (64,'Spread over a wide area',2,9);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (65,'In the morning',1,10);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (66,'at the end of the day',1,10);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (67,'My pain is there all day long ',2,10);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (68,'Yes',0,11);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (69,'Sometimes',1,11);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (70,'No',2,11);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (71,'Medication/pain killers',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (72,'Rest',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (73,'Walking',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (74,'Standing',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (75,'Sitting',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (76,'Exercise',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (77,'Massage',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (78,'Hot pack',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (79,'Cold pack',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (80,'Other',0,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (81,'I am unable to ease my back pain ',2,12);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (82,'My pain is getting better',0,13);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (83,'My pain has stayed the same',1,13);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (84,'My pain is getting worse',2,13);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (85,'Sitting relaxed',0,14);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (86,'Sitting up straight',0,14);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (87,'Standing',0,14);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (88,'Walking',0,14);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (89,'Lifting',0,14);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (90,'Forward bending ',0,14);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (91,'Any activity that I do for a long period of time increases my back pain ',1,14);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (92,'Everything I do causes me pain',2,14);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (93,'Walking',0,15);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (94,'0-Changing positions',0,15);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (95,'0-Sitting down',0,15);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (96,'Avoiding activities that causes me pain',2,15);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (97,'Stretching my back',0,15);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (98,'Moving about',0,15);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (99,'Painkillers ',1,15);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (100,'Nothing I do stops my pain',2,15);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (101,'Yes',0,16);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (102,'No',2,16);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (103,'Not sure',1,16);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (104,'Medication/ painkillers/ injections ',1,17);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (105,'Rest',1,17);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (106,'Exercise',0,17);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (107,'massage/ physiotherapy/ chiropractic/ osteopathy ',1,17);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (108,'Nothing helped ',2,17);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (109,'Yes',2,18);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (110,'No',0,18);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (111,'I don''t know',1,18);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (112,'Neck',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (113,'Right shoulder',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (114,'Left shoulder',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (115,'Right arm',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (116,'Left arm',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (117,'Upper back',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (118,'Lower back',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (119,'Right buttock',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (120,'Left buttock',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (121,'Right hip',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (122,'Left hip',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (123,'Right leg',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (124,'Left leg',1,19);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (125,'less than 5',2,20);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (126,'5-7',1,20);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (127,'8+',0,20);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (128,'Yes',2,21);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (129,'No',0,21);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (130,'Yes',0,22);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (131,'Sometimes',1,22);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (132,'No',2,22);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (133,'Agree',2,23);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (134,'Neither agree nor disagree',1,23);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (135,'Disagree',0,23);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (136,'I dont work',-1,23);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (137,'Yes',0,24);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (138,'No',2,24);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (139,'I dont know',1,24);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (140,'Not applicable',-1,24);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (141,'Not at all',0,25);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (142,'Sometimes',0,25);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (143,'Frequently',1,25);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (144,'I am unable to work becuase of my back pain',2,25);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (145,'Yes',2,26);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (146,'No',0,26);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (147,'I dont work',0,26);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (148,'Less than 3 months',0,27);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (149,'Between 1 to 6 months',1,27);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (150,'More than 6 months',2,27);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (151,'Likely',0,28);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (152,'Not sure',1,28);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (153,'Unlikely',2,28);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (154,'agree',2,29);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (155,'neither agree nor disagree',1,29);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (156,'disagree',0,29);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (157,'agree',2,30);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (158,'neither agree nor disagree',1,30);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (159,'disagree',0,30);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (160,'agree',2,31);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (161,'neither agree nor disagree',1,31);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (162,'disagree',0,31);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (163,'agree',2,32);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (164,'neither agree nor disagree',1,32);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (165,'disagree',0,32);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (166,'agree',2,33);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (167,'neither agree nor disagree',1,33);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (168,'disagree',0,33);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (169,'agree',2,34);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (170,'neither agree nor disagree',1,34);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (171,'disagree',0,34);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (172,'agree',2,35);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (173,'neither agree nor disagree',1,35);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (174,'disagree',1,35);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (175,'agree',2,36);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (176,'neither agree nor disagree',1,36);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (177,'disagree',0,36);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (178,'agree',2,37);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (179,'neither agree nor disagree',1,37);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (180,'disagree',0,37);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (181,'agree',2,38);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (182,'neither agree nor disagree',1,38);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (183,'disagree',0,38);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (184,'agree',2,39);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (185,'neither agree nor disagree',1,39);
INSERT INTO Answer(`AnswerID`,`AnswerText`, 'Score', 'QuestionID' ) VALUES (186,'disagree',0,39);
