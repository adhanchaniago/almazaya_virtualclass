-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 05, 2020 at 11:23 AM
-- Server version: 10.3.15-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `virtual_class`
--

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_indicator_calc`
--

CREATE TABLE `mdlfx_analytics_indicator_calc` (
  `id` bigint(10) NOT NULL,
  `starttime` bigint(10) NOT NULL,
  `endtime` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `sampleorigin` varchar(255) NOT NULL DEFAULT '',
  `sampleid` bigint(10) NOT NULL,
  `indicator` varchar(255) NOT NULL DEFAULT '',
  `value` decimal(10,2) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stored indicator calculations';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_models`
--

CREATE TABLE `mdlfx_analytics_models` (
  `id` bigint(10) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `trained` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(1333) DEFAULT NULL,
  `target` varchar(255) NOT NULL DEFAULT '',
  `indicators` longtext NOT NULL,
  `timesplitting` varchar(255) DEFAULT NULL,
  `predictionsprocessor` varchar(255) DEFAULT NULL,
  `version` bigint(10) NOT NULL,
  `contextids` longtext DEFAULT NULL,
  `timecreated` bigint(10) DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Analytic models.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_models_log`
--

CREATE TABLE `mdlfx_analytics_models_log` (
  `id` bigint(10) NOT NULL,
  `modelid` bigint(10) NOT NULL,
  `version` bigint(10) NOT NULL,
  `evaluationmode` varchar(50) NOT NULL DEFAULT '',
  `target` varchar(255) NOT NULL DEFAULT '',
  `indicators` longtext NOT NULL,
  `timesplitting` varchar(255) DEFAULT NULL,
  `score` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `info` longtext DEFAULT NULL,
  `dir` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Analytic models changes during evaluation.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_predictions`
--

CREATE TABLE `mdlfx_analytics_predictions` (
  `id` bigint(10) NOT NULL,
  `modelid` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `sampleid` bigint(10) NOT NULL,
  `rangeindex` mediumint(5) NOT NULL,
  `prediction` decimal(10,2) NOT NULL,
  `predictionscore` decimal(10,5) NOT NULL,
  `calculations` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timestart` bigint(10) DEFAULT NULL,
  `timeend` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Predictions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_prediction_actions`
--

CREATE TABLE `mdlfx_analytics_prediction_actions` (
  `id` bigint(10) NOT NULL,
  `predictionid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `actionname` varchar(255) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Register of user actions over predictions.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_predict_samples`
--

CREATE TABLE `mdlfx_analytics_predict_samples` (
  `id` bigint(10) NOT NULL,
  `modelid` bigint(10) NOT NULL,
  `analysableid` bigint(10) NOT NULL,
  `timesplitting` varchar(255) NOT NULL DEFAULT '',
  `rangeindex` bigint(10) NOT NULL,
  `sampleids` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Samples already used for predictions.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_train_samples`
--

CREATE TABLE `mdlfx_analytics_train_samples` (
  `id` bigint(10) NOT NULL,
  `modelid` bigint(10) NOT NULL,
  `analysableid` bigint(10) NOT NULL,
  `timesplitting` varchar(255) NOT NULL DEFAULT '',
  `sampleids` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Samples used for training';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_used_analysables`
--

CREATE TABLE `mdlfx_analytics_used_analysables` (
  `id` bigint(10) NOT NULL,
  `modelid` bigint(10) NOT NULL,
  `action` varchar(50) NOT NULL DEFAULT '',
  `analysableid` bigint(10) NOT NULL,
  `firstanalysis` bigint(10) NOT NULL,
  `timeanalysed` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of analysables used by each model';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_analytics_used_files`
--

CREATE TABLE `mdlfx_analytics_used_files` (
  `id` bigint(10) NOT NULL,
  `modelid` bigint(10) NOT NULL DEFAULT 0,
  `fileid` bigint(10) NOT NULL DEFAULT 0,
  `action` varchar(50) NOT NULL DEFAULT '',
  `time` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files that have already been used for training and predictio';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assign`
--

CREATE TABLE `mdlfx_assign` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `alwaysshowdescription` tinyint(2) NOT NULL DEFAULT 0,
  `nosubmissions` tinyint(2) NOT NULL DEFAULT 0,
  `submissiondrafts` tinyint(2) NOT NULL DEFAULT 0,
  `sendnotifications` tinyint(2) NOT NULL DEFAULT 0,
  `sendlatenotifications` tinyint(2) NOT NULL DEFAULT 0,
  `duedate` bigint(10) NOT NULL DEFAULT 0,
  `allowsubmissionsfromdate` bigint(10) NOT NULL DEFAULT 0,
  `grade` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `requiresubmissionstatement` tinyint(2) NOT NULL DEFAULT 0,
  `completionsubmit` tinyint(2) NOT NULL DEFAULT 0,
  `cutoffdate` bigint(10) NOT NULL DEFAULT 0,
  `gradingduedate` bigint(10) NOT NULL DEFAULT 0,
  `teamsubmission` tinyint(2) NOT NULL DEFAULT 0,
  `requireallteammemberssubmit` tinyint(2) NOT NULL DEFAULT 0,
  `teamsubmissiongroupingid` bigint(10) NOT NULL DEFAULT 0,
  `blindmarking` tinyint(2) NOT NULL DEFAULT 0,
  `hidegrader` tinyint(2) NOT NULL DEFAULT 0,
  `revealidentities` tinyint(2) NOT NULL DEFAULT 0,
  `attemptreopenmethod` varchar(10) NOT NULL DEFAULT 'none',
  `maxattempts` mediumint(6) NOT NULL DEFAULT -1,
  `markingworkflow` tinyint(2) NOT NULL DEFAULT 0,
  `markingallocation` tinyint(2) NOT NULL DEFAULT 0,
  `sendstudentnotifications` tinyint(2) NOT NULL DEFAULT 1,
  `preventsubmissionnotingroup` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table saves information about an instance of mod_assign';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignfeedback_comments`
--

CREATE TABLE `mdlfx_assignfeedback_comments` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `grade` bigint(10) NOT NULL DEFAULT 0,
  `commenttext` longtext DEFAULT NULL,
  `commentformat` smallint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Text feedback for submitted assignments';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignfeedback_editpdf_annot`
--

CREATE TABLE `mdlfx_assignfeedback_editpdf_annot` (
  `id` bigint(10) NOT NULL,
  `gradeid` bigint(10) NOT NULL DEFAULT 0,
  `pageno` bigint(10) NOT NULL DEFAULT 0,
  `x` bigint(10) DEFAULT 0,
  `y` bigint(10) DEFAULT 0,
  `endx` bigint(10) DEFAULT 0,
  `endy` bigint(10) DEFAULT 0,
  `path` longtext DEFAULT NULL,
  `type` varchar(10) DEFAULT 'line',
  `colour` varchar(10) DEFAULT 'black',
  `draft` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores annotations added to pdfs submitted by students';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignfeedback_editpdf_cmnt`
--

CREATE TABLE `mdlfx_assignfeedback_editpdf_cmnt` (
  `id` bigint(10) NOT NULL,
  `gradeid` bigint(10) NOT NULL DEFAULT 0,
  `x` bigint(10) DEFAULT 0,
  `y` bigint(10) DEFAULT 0,
  `width` bigint(10) DEFAULT 120,
  `rawtext` longtext DEFAULT NULL,
  `pageno` bigint(10) NOT NULL DEFAULT 0,
  `colour` varchar(10) DEFAULT 'black',
  `draft` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments added to pdfs';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignfeedback_editpdf_queue`
--

CREATE TABLE `mdlfx_assignfeedback_editpdf_queue` (
  `id` bigint(10) NOT NULL,
  `submissionid` bigint(10) NOT NULL,
  `submissionattempt` bigint(10) NOT NULL,
  `attemptedconversions` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Queue for processing.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignfeedback_editpdf_quick`
--

CREATE TABLE `mdlfx_assignfeedback_editpdf_quick` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `rawtext` longtext NOT NULL,
  `width` bigint(10) NOT NULL DEFAULT 120,
  `colour` varchar(10) DEFAULT 'yellow'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores teacher specified quicklist comments';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignfeedback_editpdf_rot`
--

CREATE TABLE `mdlfx_assignfeedback_editpdf_rot` (
  `id` bigint(10) NOT NULL,
  `gradeid` bigint(10) NOT NULL DEFAULT 0,
  `pageno` bigint(10) NOT NULL DEFAULT 0,
  `pathnamehash` longtext NOT NULL,
  `isrotated` tinyint(1) NOT NULL DEFAULT 0,
  `degree` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores rotation information of a page.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignfeedback_file`
--

CREATE TABLE `mdlfx_assignfeedback_file` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `grade` bigint(10) NOT NULL DEFAULT 0,
  `numfiles` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores info about the number of files submitted by a student';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignment`
--

CREATE TABLE `mdlfx_assignment` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `assignmenttype` varchar(50) NOT NULL DEFAULT '',
  `resubmit` tinyint(2) NOT NULL DEFAULT 0,
  `preventlate` tinyint(2) NOT NULL DEFAULT 0,
  `emailteachers` tinyint(2) NOT NULL DEFAULT 0,
  `var1` bigint(10) DEFAULT 0,
  `var2` bigint(10) DEFAULT 0,
  `var3` bigint(10) DEFAULT 0,
  `var4` bigint(10) DEFAULT 0,
  `var5` bigint(10) DEFAULT 0,
  `maxbytes` bigint(10) NOT NULL DEFAULT 100000,
  `timedue` bigint(10) NOT NULL DEFAULT 0,
  `timeavailable` bigint(10) NOT NULL DEFAULT 0,
  `grade` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines assignments';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignment_submissions`
--

CREATE TABLE `mdlfx_assignment_submissions` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `numfiles` bigint(10) NOT NULL DEFAULT 0,
  `data1` longtext DEFAULT NULL,
  `data2` longtext DEFAULT NULL,
  `grade` bigint(11) NOT NULL DEFAULT 0,
  `submissioncomment` longtext NOT NULL,
  `format` smallint(4) NOT NULL DEFAULT 0,
  `teacher` bigint(10) NOT NULL DEFAULT 0,
  `timemarked` bigint(10) NOT NULL DEFAULT 0,
  `mailed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about submitted assignments';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignment_upgrade`
--

CREATE TABLE `mdlfx_assignment_upgrade` (
  `id` bigint(10) NOT NULL,
  `oldcmid` bigint(10) NOT NULL DEFAULT 0,
  `oldinstance` bigint(10) NOT NULL DEFAULT 0,
  `newcmid` bigint(10) NOT NULL DEFAULT 0,
  `newinstance` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about upgraded assignments';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignsubmission_file`
--

CREATE TABLE `mdlfx_assignsubmission_file` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `submission` bigint(10) NOT NULL DEFAULT 0,
  `numfiles` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about file submissions for assignments';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assignsubmission_onlinetext`
--

CREATE TABLE `mdlfx_assignsubmission_onlinetext` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `submission` bigint(10) NOT NULL DEFAULT 0,
  `onlinetext` longtext DEFAULT NULL,
  `onlineformat` smallint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about onlinetext submission';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assign_grades`
--

CREATE TABLE `mdlfx_assign_grades` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `grader` bigint(10) NOT NULL DEFAULT 0,
  `grade` decimal(10,5) DEFAULT 0.00000,
  `attemptnumber` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grading information about a single assignment submission.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assign_overrides`
--

CREATE TABLE `mdlfx_assign_overrides` (
  `id` bigint(10) NOT NULL,
  `assignid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) DEFAULT NULL,
  `userid` bigint(10) DEFAULT NULL,
  `sortorder` bigint(10) DEFAULT NULL,
  `allowsubmissionsfromdate` bigint(10) DEFAULT NULL,
  `duedate` bigint(10) DEFAULT NULL,
  `cutoffdate` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The overrides to assign settings.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assign_plugin_config`
--

CREATE TABLE `mdlfx_assign_plugin_config` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `plugin` varchar(28) NOT NULL DEFAULT '',
  `subtype` varchar(28) NOT NULL DEFAULT '',
  `name` varchar(28) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Config data for an instance of a plugin in an assignment.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assign_submission`
--

CREATE TABLE `mdlfx_assign_submission` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `status` varchar(10) DEFAULT NULL,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `attemptnumber` bigint(10) NOT NULL DEFAULT 0,
  `latest` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table keeps information about student interactions with';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assign_user_flags`
--

CREATE TABLE `mdlfx_assign_user_flags` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `locked` bigint(10) NOT NULL DEFAULT 0,
  `mailed` smallint(4) NOT NULL DEFAULT 0,
  `extensionduedate` bigint(10) NOT NULL DEFAULT 0,
  `workflowstate` varchar(20) DEFAULT NULL,
  `allocatedmarker` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of flags that can be set for a single user in a single ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_assign_user_mapping`
--

CREATE TABLE `mdlfx_assign_user_mapping` (
  `id` bigint(10) NOT NULL,
  `assignment` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Map an assignment specific id number to a user';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_attendance`
--

CREATE TABLE `mdlfx_attendance` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `grade` bigint(10) NOT NULL DEFAULT 100,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `subnet` varchar(255) DEFAULT NULL,
  `sessiondetailspos` varchar(5) NOT NULL DEFAULT 'left',
  `showsessiondetails` tinyint(1) NOT NULL DEFAULT 1,
  `showextrauserdetails` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Attendance module table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_attendance_log`
--

CREATE TABLE `mdlfx_attendance_log` (
  `id` bigint(10) NOT NULL,
  `sessionid` bigint(10) NOT NULL DEFAULT 0,
  `studentid` bigint(10) NOT NULL DEFAULT 0,
  `statusid` bigint(10) NOT NULL DEFAULT 0,
  `statusset` varchar(1333) DEFAULT NULL,
  `timetaken` bigint(10) NOT NULL DEFAULT 0,
  `takenby` bigint(10) NOT NULL DEFAULT 0,
  `remarks` varchar(255) DEFAULT NULL,
  `ipaddress` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='attendance_log table retrofitted from MySQL';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_attendance_rotate_passwords`
--

CREATE TABLE `mdlfx_attendance_rotate_passwords` (
  `id` bigint(10) NOT NULL,
  `attendanceid` bigint(10) NOT NULL,
  `password` varchar(20) NOT NULL DEFAULT '',
  `expirytime` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to hold temporary passwords for rotate QR code feature';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_attendance_sessions`
--

CREATE TABLE `mdlfx_attendance_sessions` (
  `id` bigint(10) NOT NULL,
  `attendanceid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `sessdate` bigint(10) NOT NULL DEFAULT 0,
  `duration` bigint(10) NOT NULL DEFAULT 0,
  `lasttaken` bigint(10) DEFAULT NULL,
  `lasttakenby` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) DEFAULT NULL,
  `description` longtext NOT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0,
  `studentscanmark` tinyint(1) NOT NULL DEFAULT 0,
  `autoassignstatus` tinyint(1) NOT NULL DEFAULT 0,
  `studentpassword` varchar(50) DEFAULT '',
  `subnet` varchar(255) DEFAULT NULL,
  `automark` tinyint(1) NOT NULL DEFAULT 0,
  `automarkcompleted` tinyint(1) NOT NULL DEFAULT 0,
  `statusset` mediumint(5) NOT NULL DEFAULT 0,
  `absenteereport` tinyint(1) NOT NULL DEFAULT 1,
  `preventsharedip` tinyint(1) NOT NULL DEFAULT 0,
  `preventsharediptime` bigint(10) DEFAULT NULL,
  `caleventid` bigint(10) NOT NULL DEFAULT 0,
  `calendarevent` tinyint(1) NOT NULL DEFAULT 1,
  `includeqrcode` tinyint(1) NOT NULL DEFAULT 0,
  `rotateqrcode` tinyint(1) NOT NULL DEFAULT 0,
  `rotateqrcodesecret` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='attendance_sessions table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_attendance_statuses`
--

CREATE TABLE `mdlfx_attendance_statuses` (
  `id` bigint(10) NOT NULL,
  `attendanceid` bigint(10) NOT NULL DEFAULT 0,
  `acronym` varchar(2) NOT NULL DEFAULT '',
  `description` varchar(30) NOT NULL DEFAULT '',
  `grade` decimal(5,2) NOT NULL DEFAULT 0.00,
  `studentavailability` bigint(10) DEFAULT NULL,
  `setunmarked` tinyint(2) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `setnumber` mediumint(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='attendance_statuses table retrofitted from MySQL';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_attendance_tempusers`
--

CREATE TABLE `mdlfx_attendance_tempusers` (
  `id` bigint(10) NOT NULL,
  `studentid` bigint(10) DEFAULT NULL,
  `courseid` bigint(10) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores temporary users details';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_attendance_warning`
--

CREATE TABLE `mdlfx_attendance_warning` (
  `id` bigint(10) NOT NULL,
  `idnumber` bigint(10) NOT NULL,
  `warningpercent` bigint(10) NOT NULL,
  `warnafter` bigint(10) NOT NULL,
  `maxwarn` bigint(10) NOT NULL DEFAULT 1,
  `emailuser` smallint(4) NOT NULL,
  `emailsubject` varchar(255) NOT NULL DEFAULT '',
  `emailcontent` longtext NOT NULL,
  `emailcontentformat` smallint(4) NOT NULL,
  `thirdpartyemails` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Warning configuration';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_attendance_warning_done`
--

CREATE TABLE `mdlfx_attendance_warning_done` (
  `id` bigint(10) NOT NULL,
  `notifyid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timesent` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Warnings processed';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_auth_oauth2_linked_login`
--

CREATE TABLE `mdlfx_auth_oauth2_linked_login` (
  `id` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `issuerid` bigint(10) NOT NULL,
  `username` varchar(255) NOT NULL DEFAULT '',
  `email` longtext NOT NULL,
  `confirmtoken` varchar(64) NOT NULL DEFAULT '',
  `confirmtokenexpires` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Accounts linked to a users Moodle account.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_backup_controllers`
--

CREATE TABLE `mdlfx_backup_controllers` (
  `id` bigint(10) NOT NULL,
  `backupid` varchar(32) NOT NULL DEFAULT '',
  `operation` varchar(20) NOT NULL DEFAULT 'backup',
  `type` varchar(10) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL,
  `format` varchar(20) NOT NULL DEFAULT '',
  `interactive` smallint(4) NOT NULL,
  `purpose` smallint(4) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `status` smallint(4) NOT NULL,
  `execution` smallint(4) NOT NULL,
  `executiontime` bigint(10) NOT NULL,
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `progress` decimal(15,14) NOT NULL DEFAULT 0.00000000000000,
  `controller` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store the backup_controllers as they are used';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_backup_courses`
--

CREATE TABLE `mdlfx_backup_courses` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `laststarttime` bigint(10) NOT NULL DEFAULT 0,
  `lastendtime` bigint(10) NOT NULL DEFAULT 0,
  `laststatus` varchar(1) NOT NULL DEFAULT '5',
  `nextstarttime` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store every course backup status';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_backup_logs`
--

CREATE TABLE `mdlfx_backup_logs` (
  `id` bigint(10) NOT NULL,
  `backupid` varchar(32) NOT NULL DEFAULT '',
  `loglevel` smallint(4) NOT NULL,
  `message` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To store all the logs from backup and restore operations (by';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge`
--

CREATE TABLE `mdlfx_badge` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `usercreated` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `issuername` varchar(255) NOT NULL DEFAULT '',
  `issuerurl` varchar(255) NOT NULL DEFAULT '',
  `issuercontact` varchar(255) DEFAULT NULL,
  `expiredate` bigint(10) DEFAULT NULL,
  `expireperiod` bigint(10) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 1,
  `courseid` bigint(10) DEFAULT NULL,
  `message` longtext NOT NULL,
  `messagesubject` longtext NOT NULL,
  `attachment` tinyint(1) NOT NULL DEFAULT 1,
  `notification` tinyint(1) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `nextcron` bigint(10) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `imageauthorname` varchar(255) DEFAULT NULL,
  `imageauthoremail` varchar(255) DEFAULT NULL,
  `imageauthorurl` varchar(255) DEFAULT NULL,
  `imagecaption` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines badge';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_alignment`
--

CREATE TABLE `mdlfx_badge_alignment` (
  `id` bigint(10) NOT NULL,
  `badgeid` bigint(10) NOT NULL DEFAULT 0,
  `targetname` varchar(255) NOT NULL DEFAULT '',
  `targeturl` varchar(255) NOT NULL DEFAULT '',
  `targetdescription` longtext DEFAULT NULL,
  `targetframework` varchar(255) DEFAULT NULL,
  `targetcode` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines alignment for badges';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_backpack`
--

CREATE TABLE `mdlfx_badge_backpack` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `email` varchar(100) NOT NULL DEFAULT '',
  `backpackuid` bigint(10) NOT NULL,
  `autosync` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(50) DEFAULT NULL,
  `externalbackpackid` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines settings for connecting external backpack';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_criteria`
--

CREATE TABLE `mdlfx_badge_criteria` (
  `id` bigint(10) NOT NULL,
  `badgeid` bigint(10) NOT NULL DEFAULT 0,
  `criteriatype` bigint(10) DEFAULT NULL,
  `method` tinyint(1) NOT NULL DEFAULT 1,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines criteria for issuing badges';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_criteria_met`
--

CREATE TABLE `mdlfx_badge_criteria_met` (
  `id` bigint(10) NOT NULL,
  `issuedid` bigint(10) DEFAULT NULL,
  `critid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `datemet` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines criteria that were met for an issued badge';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_criteria_param`
--

CREATE TABLE `mdlfx_badge_criteria_param` (
  `id` bigint(10) NOT NULL,
  `critid` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines parameters for badges criteria';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_endorsement`
--

CREATE TABLE `mdlfx_badge_endorsement` (
  `id` bigint(10) NOT NULL,
  `badgeid` bigint(10) NOT NULL DEFAULT 0,
  `issuername` varchar(255) NOT NULL DEFAULT '',
  `issuerurl` varchar(255) NOT NULL DEFAULT '',
  `issueremail` varchar(255) NOT NULL DEFAULT '',
  `claimid` varchar(255) DEFAULT NULL,
  `claimcomment` longtext DEFAULT NULL,
  `dateissued` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines endorsement for badge';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_external`
--

CREATE TABLE `mdlfx_badge_external` (
  `id` bigint(10) NOT NULL,
  `backpackid` bigint(10) NOT NULL,
  `collectionid` bigint(10) NOT NULL,
  `entityid` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Setting for external badges display';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_external_backpack`
--

CREATE TABLE `mdlfx_badge_external_backpack` (
  `id` bigint(10) NOT NULL,
  `backpackapiurl` varchar(255) NOT NULL DEFAULT '',
  `backpackweburl` varchar(255) NOT NULL DEFAULT '',
  `apiversion` varchar(12) NOT NULL DEFAULT '1.0',
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines settings for site level backpacks that a user can co';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_external_identifier`
--

CREATE TABLE `mdlfx_badge_external_identifier` (
  `id` bigint(10) NOT NULL,
  `sitebackpackid` bigint(10) NOT NULL,
  `internalid` varchar(128) NOT NULL DEFAULT '',
  `externalid` varchar(128) NOT NULL DEFAULT '',
  `type` varchar(16) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Setting for external badges mappings';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_issued`
--

CREATE TABLE `mdlfx_badge_issued` (
  `id` bigint(10) NOT NULL,
  `badgeid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `uniquehash` longtext NOT NULL,
  `dateissued` bigint(10) NOT NULL DEFAULT 0,
  `dateexpire` bigint(10) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 0,
  `issuernotified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines issued badges';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_manual_award`
--

CREATE TABLE `mdlfx_badge_manual_award` (
  `id` bigint(10) NOT NULL,
  `badgeid` bigint(10) NOT NULL,
  `recipientid` bigint(10) NOT NULL,
  `issuerid` bigint(10) NOT NULL,
  `issuerrole` bigint(10) NOT NULL,
  `datemet` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track manual award criteria for badges';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_badge_related`
--

CREATE TABLE `mdlfx_badge_related` (
  `id` bigint(10) NOT NULL,
  `badgeid` bigint(10) NOT NULL DEFAULT 0,
  `relatedbadgeid` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines badge related for badges';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_block`
--

CREATE TABLE `mdlfx_block` (
  `id` bigint(10) NOT NULL,
  `name` varchar(40) NOT NULL DEFAULT '',
  `cron` bigint(10) NOT NULL DEFAULT 0,
  `lastcron` bigint(10) NOT NULL DEFAULT 0,
  `visible` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='contains all installed blocks';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_block_instances`
--

CREATE TABLE `mdlfx_block_instances` (
  `id` bigint(10) NOT NULL,
  `blockname` varchar(40) NOT NULL DEFAULT '',
  `parentcontextid` bigint(10) NOT NULL,
  `showinsubcontexts` smallint(4) NOT NULL,
  `requiredbytheme` smallint(4) NOT NULL DEFAULT 0,
  `pagetypepattern` varchar(64) NOT NULL DEFAULT '',
  `subpagepattern` varchar(16) DEFAULT NULL,
  `defaultregion` varchar(16) NOT NULL DEFAULT '',
  `defaultweight` bigint(10) NOT NULL,
  `configdata` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores block instances. The type of block this is';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_block_positions`
--

CREATE TABLE `mdlfx_block_positions` (
  `id` bigint(10) NOT NULL,
  `blockinstanceid` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `pagetype` varchar(64) NOT NULL DEFAULT '',
  `subpage` varchar(16) NOT NULL DEFAULT '',
  `visible` smallint(4) NOT NULL,
  `region` varchar(16) NOT NULL DEFAULT '',
  `weight` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the position of a sticky block_instance on a another ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_block_recentlyaccesseditems`
--

CREATE TABLE `mdlfx_block_recentlyaccesseditems` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `cmid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timeaccess` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most recently accessed items accessed by a user';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_block_recent_activity`
--

CREATE TABLE `mdlfx_block_recent_activity` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `cmid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `action` tinyint(1) NOT NULL,
  `modname` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Recent activity block';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_block_rss_client`
--

CREATE TABLE `mdlfx_block_rss_client` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `title` longtext NOT NULL,
  `preferredtitle` varchar(64) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `shared` tinyint(2) NOT NULL DEFAULT 0,
  `url` varchar(255) NOT NULL DEFAULT '',
  `skiptime` bigint(10) NOT NULL DEFAULT 0,
  `skipuntil` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Remote news feed information. Contains the news feed id, the';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_blog_association`
--

CREATE TABLE `mdlfx_blog_association` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `blogid` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Associations of blog entries with courses and module instanc';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_blog_external`
--

CREATE TABLE `mdlfx_blog_external` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `url` longtext NOT NULL,
  `filtertags` varchar(255) DEFAULT NULL,
  `failedlastsync` tinyint(1) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) DEFAULT NULL,
  `timefetched` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='External blog links used for RSS copying of blog entries to ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_book`
--

CREATE TABLE `mdlfx_book` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `numbering` smallint(4) NOT NULL DEFAULT 0,
  `navstyle` smallint(4) NOT NULL DEFAULT 1,
  `customtitles` tinyint(2) NOT NULL DEFAULT 0,
  `revision` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines book';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_book_chapters`
--

CREATE TABLE `mdlfx_book_chapters` (
  `id` bigint(10) NOT NULL,
  `bookid` bigint(10) NOT NULL DEFAULT 0,
  `pagenum` bigint(10) NOT NULL DEFAULT 0,
  `subchapter` bigint(10) NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` longtext NOT NULL,
  `contentformat` smallint(4) NOT NULL DEFAULT 0,
  `hidden` tinyint(2) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `importsrc` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines book_chapters';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_cache_filters`
--

CREATE TABLE `mdlfx_cache_filters` (
  `id` bigint(10) NOT NULL,
  `filter` varchar(32) NOT NULL DEFAULT '',
  `version` bigint(10) NOT NULL DEFAULT 0,
  `md5key` varchar(32) NOT NULL DEFAULT '',
  `rawtext` longtext NOT NULL,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='For keeping information about cached data';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_cache_flags`
--

CREATE TABLE `mdlfx_cache_flags` (
  `id` bigint(10) NOT NULL,
  `flagtype` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `value` longtext NOT NULL,
  `expiry` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache of time-sensitive flags';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_capabilities`
--

CREATE TABLE `mdlfx_capabilities` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `captype` varchar(50) NOT NULL DEFAULT '',
  `contextlevel` bigint(10) NOT NULL DEFAULT 0,
  `component` varchar(100) NOT NULL DEFAULT '',
  `riskbitmask` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='this defines all capabilities';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_chat`
--

CREATE TABLE `mdlfx_chat` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `keepdays` bigint(11) NOT NULL DEFAULT 0,
  `studentlogs` smallint(4) NOT NULL DEFAULT 0,
  `chattime` bigint(10) NOT NULL DEFAULT 0,
  `schedule` smallint(4) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each of these is a chat room';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_chat_messages`
--

CREATE TABLE `mdlfx_chat_messages` (
  `id` bigint(10) NOT NULL,
  `chatid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `issystem` tinyint(1) NOT NULL DEFAULT 0,
  `message` longtext NOT NULL,
  `timestamp` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all the actual chat messages';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_chat_messages_current`
--

CREATE TABLE `mdlfx_chat_messages_current` (
  `id` bigint(10) NOT NULL,
  `chatid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `issystem` tinyint(1) NOT NULL DEFAULT 0,
  `message` longtext NOT NULL,
  `timestamp` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores current session';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_chat_users`
--

CREATE TABLE `mdlfx_chat_users` (
  `id` bigint(10) NOT NULL,
  `chatid` bigint(11) NOT NULL DEFAULT 0,
  `userid` bigint(11) NOT NULL DEFAULT 0,
  `groupid` bigint(11) NOT NULL DEFAULT 0,
  `version` varchar(16) NOT NULL DEFAULT '',
  `ip` varchar(45) NOT NULL DEFAULT '',
  `firstping` bigint(10) NOT NULL DEFAULT 0,
  `lastping` bigint(10) NOT NULL DEFAULT 0,
  `lastmessageping` bigint(10) NOT NULL DEFAULT 0,
  `sid` varchar(32) NOT NULL DEFAULT '',
  `course` bigint(10) NOT NULL DEFAULT 0,
  `lang` varchar(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeps track of which users are in which chat rooms';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_choice`
--

CREATE TABLE `mdlfx_choice` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `publish` tinyint(2) NOT NULL DEFAULT 0,
  `showresults` tinyint(2) NOT NULL DEFAULT 0,
  `display` smallint(4) NOT NULL DEFAULT 0,
  `allowupdate` tinyint(2) NOT NULL DEFAULT 0,
  `allowmultiple` tinyint(2) NOT NULL DEFAULT 0,
  `showunanswered` tinyint(2) NOT NULL DEFAULT 0,
  `includeinactive` tinyint(2) NOT NULL DEFAULT 1,
  `limitanswers` tinyint(2) NOT NULL DEFAULT 0,
  `timeopen` bigint(10) NOT NULL DEFAULT 0,
  `timeclose` bigint(10) NOT NULL DEFAULT 0,
  `showpreview` tinyint(2) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `completionsubmit` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Available choices are stored here';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_choice_answers`
--

CREATE TABLE `mdlfx_choice_answers` (
  `id` bigint(10) NOT NULL,
  `choiceid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `optionid` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='choices performed by users';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_choice_options`
--

CREATE TABLE `mdlfx_choice_options` (
  `id` bigint(10) NOT NULL,
  `choiceid` bigint(10) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `maxanswers` bigint(10) DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='available options to choice';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_cohort`
--

CREATE TABLE `mdlfx_cohort` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `name` varchar(254) NOT NULL DEFAULT '',
  `idnumber` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `component` varchar(100) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `theme` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record represents one cohort (aka site-wide group).';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_cohort_members`
--

CREATE TABLE `mdlfx_cohort_members` (
  `id` bigint(10) NOT NULL,
  `cohortid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `timeadded` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a user to a cohort.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_comments`
--

CREATE TABLE `mdlfx_comments` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `component` varchar(255) DEFAULT NULL,
  `commentarea` varchar(255) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL,
  `content` longtext NOT NULL,
  `format` tinyint(2) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='moodle comments module';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency`
--

CREATE TABLE `mdlfx_competency` (
  `id` bigint(10) NOT NULL,
  `shortname` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` smallint(4) NOT NULL DEFAULT 0,
  `idnumber` varchar(100) DEFAULT NULL,
  `competencyframeworkid` bigint(10) NOT NULL,
  `parentid` bigint(10) NOT NULL DEFAULT 0,
  `path` varchar(255) NOT NULL DEFAULT '',
  `sortorder` bigint(10) NOT NULL,
  `ruletype` varchar(100) DEFAULT NULL,
  `ruleoutcome` tinyint(2) NOT NULL DEFAULT 0,
  `ruleconfig` longtext DEFAULT NULL,
  `scaleid` bigint(10) DEFAULT NULL,
  `scaleconfiguration` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table contains the master record of each competency in ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_coursecomp`
--

CREATE TABLE `mdlfx_competency_coursecomp` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `ruleoutcome` tinyint(2) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `sortorder` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a competency to a course.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_coursecompsetting`
--

CREATE TABLE `mdlfx_competency_coursecompsetting` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `pushratingstouserplans` tinyint(2) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table contains the course specific settings for compete';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_evidence`
--

CREATE TABLE `mdlfx_competency_evidence` (
  `id` bigint(10) NOT NULL,
  `usercompetencyid` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `action` tinyint(2) NOT NULL,
  `actionuserid` bigint(10) DEFAULT NULL,
  `descidentifier` varchar(255) NOT NULL DEFAULT '',
  `desccomponent` varchar(255) NOT NULL DEFAULT '',
  `desca` longtext DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `grade` bigint(10) DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The evidence linked to a user competency';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_framework`
--

CREATE TABLE `mdlfx_competency_framework` (
  `id` bigint(10) NOT NULL,
  `shortname` varchar(100) DEFAULT NULL,
  `contextid` bigint(10) NOT NULL,
  `idnumber` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` smallint(4) NOT NULL DEFAULT 0,
  `scaleid` bigint(11) DEFAULT NULL,
  `scaleconfiguration` longtext NOT NULL,
  `visible` tinyint(2) NOT NULL DEFAULT 1,
  `taxonomies` varchar(255) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of competency frameworks.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_modulecomp`
--

CREATE TABLE `mdlfx_competency_modulecomp` (
  `id` bigint(10) NOT NULL,
  `cmid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `sortorder` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `ruleoutcome` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a competency to a module.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_plan`
--

CREATE TABLE `mdlfx_competency_plan` (
  `id` bigint(10) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` smallint(4) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL,
  `templateid` bigint(10) DEFAULT NULL,
  `origtemplateid` bigint(10) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `duedate` bigint(10) DEFAULT 0,
  `reviewerid` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Learning plans';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_plancomp`
--

CREATE TABLE `mdlfx_competency_plancomp` (
  `id` bigint(10) NOT NULL,
  `planid` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `sortorder` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Plan competencies';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_relatedcomp`
--

CREATE TABLE `mdlfx_competency_relatedcomp` (
  `id` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `relatedcompetencyid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Related competencies';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_template`
--

CREATE TABLE `mdlfx_competency_template` (
  `id` bigint(10) NOT NULL,
  `shortname` varchar(100) DEFAULT NULL,
  `contextid` bigint(10) NOT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` smallint(4) NOT NULL DEFAULT 0,
  `visible` tinyint(2) NOT NULL DEFAULT 1,
  `duedate` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Learning plan templates.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_templatecohort`
--

CREATE TABLE `mdlfx_competency_templatecohort` (
  `id` bigint(10) NOT NULL,
  `templateid` bigint(10) NOT NULL,
  `cohortid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Default comment for the table, please edit me';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_templatecomp`
--

CREATE TABLE `mdlfx_competency_templatecomp` (
  `id` bigint(10) NOT NULL,
  `templateid` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `sortorder` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a competency to a learning plan template.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_usercomp`
--

CREATE TABLE `mdlfx_competency_usercomp` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `reviewerid` bigint(10) DEFAULT NULL,
  `proficiency` tinyint(2) DEFAULT NULL,
  `grade` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User competencies';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_usercompcourse`
--

CREATE TABLE `mdlfx_competency_usercompcourse` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `proficiency` tinyint(2) DEFAULT NULL,
  `grade` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User competencies in a course';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_usercompplan`
--

CREATE TABLE `mdlfx_competency_usercompplan` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `planid` bigint(10) NOT NULL,
  `proficiency` tinyint(2) DEFAULT NULL,
  `grade` bigint(10) DEFAULT NULL,
  `sortorder` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User competencies plans';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_userevidence`
--

CREATE TABLE `mdlfx_competency_userevidence` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `descriptionformat` tinyint(1) NOT NULL,
  `url` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The evidence of prior learning';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_competency_userevidencecomp`
--

CREATE TABLE `mdlfx_competency_userevidencecomp` (
  `id` bigint(10) NOT NULL,
  `userevidenceid` bigint(10) NOT NULL,
  `competencyid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between user evidence and competencies';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_config`
--

CREATE TABLE `mdlfx_config` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Moodle configuration variables';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_config_log`
--

CREATE TABLE `mdlfx_config_log` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `plugin` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL,
  `oldvalue` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Changes done in server configuration through admin UI';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_config_plugins`
--

CREATE TABLE `mdlfx_config_plugins` (
  `id` bigint(10) NOT NULL,
  `plugin` varchar(100) NOT NULL DEFAULT 'core',
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Moodle modules and plugins configuration variables';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_context`
--

CREATE TABLE `mdlfx_context` (
  `id` bigint(10) NOT NULL,
  `contextlevel` bigint(10) NOT NULL DEFAULT 0,
  `instanceid` bigint(10) NOT NULL DEFAULT 0,
  `path` varchar(255) DEFAULT NULL,
  `depth` tinyint(2) NOT NULL DEFAULT 0,
  `locked` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='one of these must be set';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_context_temp`
--

CREATE TABLE `mdlfx_context_temp` (
  `id` bigint(10) NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '',
  `depth` tinyint(2) NOT NULL,
  `locked` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used by build_context_path() in upgrade and cron to keep con';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course`
--

CREATE TABLE `mdlfx_course` (
  `id` bigint(10) NOT NULL,
  `category` bigint(10) NOT NULL DEFAULT 0,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(255) NOT NULL DEFAULT '',
  `idnumber` varchar(100) NOT NULL DEFAULT '',
  `summary` longtext DEFAULT NULL,
  `summaryformat` tinyint(2) NOT NULL DEFAULT 0,
  `format` varchar(21) NOT NULL DEFAULT 'topics',
  `showgrades` tinyint(2) NOT NULL DEFAULT 1,
  `newsitems` mediumint(5) NOT NULL DEFAULT 1,
  `startdate` bigint(10) NOT NULL DEFAULT 0,
  `enddate` bigint(10) NOT NULL DEFAULT 0,
  `relativedatesmode` tinyint(1) NOT NULL DEFAULT 0,
  `marker` bigint(10) NOT NULL DEFAULT 0,
  `maxbytes` bigint(10) NOT NULL DEFAULT 0,
  `legacyfiles` smallint(4) NOT NULL DEFAULT 0,
  `showreports` smallint(4) NOT NULL DEFAULT 0,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `visibleold` tinyint(1) NOT NULL DEFAULT 1,
  `groupmode` smallint(4) NOT NULL DEFAULT 0,
  `groupmodeforce` smallint(4) NOT NULL DEFAULT 0,
  `defaultgroupingid` bigint(10) NOT NULL DEFAULT 0,
  `lang` varchar(30) NOT NULL DEFAULT '',
  `calendartype` varchar(30) NOT NULL DEFAULT '',
  `theme` varchar(50) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `requested` tinyint(1) NOT NULL DEFAULT 0,
  `enablecompletion` tinyint(1) NOT NULL DEFAULT 0,
  `completionnotify` tinyint(1) NOT NULL DEFAULT 0,
  `cacherev` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Central course table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_categories`
--

CREATE TABLE `mdlfx_course_categories` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `idnumber` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0,
  `parent` bigint(10) NOT NULL DEFAULT 0,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `coursecount` bigint(10) NOT NULL DEFAULT 0,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `visibleold` tinyint(1) NOT NULL DEFAULT 1,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `depth` bigint(10) NOT NULL DEFAULT 0,
  `path` varchar(255) NOT NULL DEFAULT '',
  `theme` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course categories';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_completions`
--

CREATE TABLE `mdlfx_course_completions` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `timeenrolled` bigint(10) NOT NULL DEFAULT 0,
  `timestarted` bigint(10) NOT NULL DEFAULT 0,
  `timecompleted` bigint(10) DEFAULT NULL,
  `reaggregate` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion records';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_completion_aggr_methd`
--

CREATE TABLE `mdlfx_course_completion_aggr_methd` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `criteriatype` bigint(10) DEFAULT NULL,
  `method` tinyint(1) NOT NULL DEFAULT 0,
  `value` decimal(10,5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion aggregation methods for criteria';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_completion_criteria`
--

CREATE TABLE `mdlfx_course_completion_criteria` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `criteriatype` bigint(10) NOT NULL DEFAULT 0,
  `module` varchar(100) DEFAULT NULL,
  `moduleinstance` bigint(10) DEFAULT NULL,
  `courseinstance` bigint(10) DEFAULT NULL,
  `enrolperiod` bigint(10) DEFAULT NULL,
  `timeend` bigint(10) DEFAULT NULL,
  `gradepass` decimal(10,5) DEFAULT NULL,
  `role` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion criteria';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_completion_crit_compl`
--

CREATE TABLE `mdlfx_course_completion_crit_compl` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `criteriaid` bigint(10) NOT NULL DEFAULT 0,
  `gradefinal` decimal(10,5) DEFAULT NULL,
  `unenroled` bigint(10) DEFAULT NULL,
  `timecompleted` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Course completion user records';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_completion_defaults`
--

CREATE TABLE `mdlfx_course_completion_defaults` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL,
  `module` bigint(10) NOT NULL,
  `completion` tinyint(1) NOT NULL DEFAULT 0,
  `completionview` tinyint(1) NOT NULL DEFAULT 0,
  `completionusegrade` tinyint(1) NOT NULL DEFAULT 0,
  `completionexpected` bigint(10) NOT NULL DEFAULT 0,
  `customrules` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Default settings for activities completion';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_format_options`
--

CREATE TABLE `mdlfx_course_format_options` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `format` varchar(21) NOT NULL DEFAULT '',
  `sectionid` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores format-specific options for the course or course sect';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_modules`
--

CREATE TABLE `mdlfx_course_modules` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `module` bigint(10) NOT NULL DEFAULT 0,
  `instance` bigint(10) NOT NULL DEFAULT 0,
  `section` bigint(10) NOT NULL DEFAULT 0,
  `idnumber` varchar(100) DEFAULT NULL,
  `added` bigint(10) NOT NULL DEFAULT 0,
  `score` smallint(4) NOT NULL DEFAULT 0,
  `indent` mediumint(5) NOT NULL DEFAULT 0,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `visibleoncoursepage` tinyint(1) NOT NULL DEFAULT 1,
  `visibleold` tinyint(1) NOT NULL DEFAULT 1,
  `groupmode` smallint(4) NOT NULL DEFAULT 0,
  `groupingid` bigint(10) NOT NULL DEFAULT 0,
  `completion` tinyint(1) NOT NULL DEFAULT 0,
  `completiongradeitemnumber` bigint(10) DEFAULT NULL,
  `completionview` tinyint(1) NOT NULL DEFAULT 0,
  `completionexpected` bigint(10) NOT NULL DEFAULT 0,
  `showdescription` tinyint(1) NOT NULL DEFAULT 0,
  `availability` longtext DEFAULT NULL,
  `deletioninprogress` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='course_modules table retrofitted from MySQL';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_modules_completion`
--

CREATE TABLE `mdlfx_course_modules_completion` (
  `id` bigint(10) NOT NULL,
  `coursemoduleid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `completionstate` tinyint(1) NOT NULL,
  `viewed` tinyint(1) DEFAULT NULL,
  `overrideby` bigint(10) DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the completion state (completed or not completed, etc';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_published`
--

CREATE TABLE `mdlfx_course_published` (
  `id` bigint(10) NOT NULL,
  `huburl` varchar(255) DEFAULT NULL,
  `courseid` bigint(10) NOT NULL,
  `timepublished` bigint(10) NOT NULL,
  `enrollable` tinyint(1) NOT NULL DEFAULT 1,
  `hubcourseid` bigint(10) NOT NULL,
  `status` tinyint(1) DEFAULT 0,
  `timechecked` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Information about how and when an local courses were publish';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_request`
--

CREATE TABLE `mdlfx_course_request` (
  `id` bigint(10) NOT NULL,
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `summary` longtext NOT NULL,
  `summaryformat` tinyint(2) NOT NULL DEFAULT 0,
  `category` bigint(10) NOT NULL DEFAULT 0,
  `reason` longtext NOT NULL,
  `requester` bigint(10) NOT NULL DEFAULT 0,
  `password` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='course requests';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_course_sections`
--

CREATE TABLE `mdlfx_course_sections` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `section` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `summary` longtext DEFAULT NULL,
  `summaryformat` tinyint(2) NOT NULL DEFAULT 0,
  `sequence` longtext DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `availability` longtext DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='to define the sections for each course';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_customfield_category`
--

CREATE TABLE `mdlfx_customfield_category` (
  `id` bigint(10) NOT NULL,
  `name` varchar(400) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` bigint(10) DEFAULT NULL,
  `sortorder` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `area` varchar(100) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL DEFAULT 0,
  `contextid` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='core_customfield category table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_customfield_data`
--

CREATE TABLE `mdlfx_customfield_data` (
  `id` bigint(10) NOT NULL,
  `fieldid` bigint(10) NOT NULL,
  `instanceid` bigint(10) NOT NULL,
  `intvalue` bigint(10) DEFAULT NULL,
  `decvalue` decimal(10,5) DEFAULT NULL,
  `shortcharvalue` varchar(255) DEFAULT NULL,
  `charvalue` varchar(1333) DEFAULT NULL,
  `value` longtext NOT NULL,
  `valueformat` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `contextid` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='core_customfield data table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_customfield_field`
--

CREATE TABLE `mdlfx_customfield_field` (
  `id` bigint(10) NOT NULL,
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(400) NOT NULL DEFAULT '',
  `type` varchar(100) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` bigint(10) DEFAULT NULL,
  `sortorder` bigint(10) DEFAULT NULL,
  `categoryid` bigint(10) DEFAULT NULL,
  `configdata` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='core_customfield field table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_data`
--

CREATE TABLE `mdlfx_data` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `comments` smallint(4) NOT NULL DEFAULT 0,
  `timeavailablefrom` bigint(10) NOT NULL DEFAULT 0,
  `timeavailableto` bigint(10) NOT NULL DEFAULT 0,
  `timeviewfrom` bigint(10) NOT NULL DEFAULT 0,
  `timeviewto` bigint(10) NOT NULL DEFAULT 0,
  `requiredentries` int(8) NOT NULL DEFAULT 0,
  `requiredentriestoview` int(8) NOT NULL DEFAULT 0,
  `maxentries` int(8) NOT NULL DEFAULT 0,
  `rssarticles` smallint(4) NOT NULL DEFAULT 0,
  `singletemplate` longtext DEFAULT NULL,
  `listtemplate` longtext DEFAULT NULL,
  `listtemplateheader` longtext DEFAULT NULL,
  `listtemplatefooter` longtext DEFAULT NULL,
  `addtemplate` longtext DEFAULT NULL,
  `rsstemplate` longtext DEFAULT NULL,
  `rsstitletemplate` longtext DEFAULT NULL,
  `csstemplate` longtext DEFAULT NULL,
  `jstemplate` longtext DEFAULT NULL,
  `asearchtemplate` longtext DEFAULT NULL,
  `approval` smallint(4) NOT NULL DEFAULT 0,
  `manageapproved` smallint(4) NOT NULL DEFAULT 1,
  `scale` bigint(10) NOT NULL DEFAULT 0,
  `assessed` bigint(10) NOT NULL DEFAULT 0,
  `assesstimestart` bigint(10) NOT NULL DEFAULT 0,
  `assesstimefinish` bigint(10) NOT NULL DEFAULT 0,
  `defaultsort` bigint(10) NOT NULL DEFAULT 0,
  `defaultsortdir` smallint(4) NOT NULL DEFAULT 0,
  `editany` smallint(4) NOT NULL DEFAULT 0,
  `notification` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `config` longtext DEFAULT NULL,
  `completionentries` bigint(10) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all database activities';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_data_content`
--

CREATE TABLE `mdlfx_data_content` (
  `id` bigint(10) NOT NULL,
  `fieldid` bigint(10) NOT NULL DEFAULT 0,
  `recordid` bigint(10) NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `content1` longtext DEFAULT NULL,
  `content2` longtext DEFAULT NULL,
  `content3` longtext DEFAULT NULL,
  `content4` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='the content introduced in each record/fields';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_data_fields`
--

CREATE TABLE `mdlfx_data_fields` (
  `id` bigint(10) NOT NULL,
  `dataid` bigint(10) NOT NULL DEFAULT 0,
  `type` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `param1` longtext DEFAULT NULL,
  `param2` longtext DEFAULT NULL,
  `param3` longtext DEFAULT NULL,
  `param4` longtext DEFAULT NULL,
  `param5` longtext DEFAULT NULL,
  `param6` longtext DEFAULT NULL,
  `param7` longtext DEFAULT NULL,
  `param8` longtext DEFAULT NULL,
  `param9` longtext DEFAULT NULL,
  `param10` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='every field available';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_data_records`
--

CREATE TABLE `mdlfx_data_records` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `dataid` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `approved` smallint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='every record introduced';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_editor_atto_autosave`
--

CREATE TABLE `mdlfx_editor_atto_autosave` (
  `id` bigint(10) NOT NULL,
  `elementid` varchar(255) NOT NULL DEFAULT '',
  `contextid` bigint(10) NOT NULL,
  `pagehash` varchar(64) NOT NULL DEFAULT '',
  `userid` bigint(10) NOT NULL,
  `drafttext` longtext NOT NULL,
  `draftid` bigint(10) DEFAULT NULL,
  `pageinstance` varchar(64) NOT NULL DEFAULT '',
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Draft text that is auto-saved every 5 seconds while an edito';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol`
--

CREATE TABLE `mdlfx_enrol` (
  `id` bigint(10) NOT NULL,
  `enrol` varchar(20) NOT NULL DEFAULT '',
  `status` bigint(10) NOT NULL DEFAULT 0,
  `courseid` bigint(10) NOT NULL,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `enrolperiod` bigint(10) DEFAULT 0,
  `enrolstartdate` bigint(10) DEFAULT 0,
  `enrolenddate` bigint(10) DEFAULT 0,
  `expirynotify` tinyint(1) DEFAULT 0,
  `expirythreshold` bigint(10) DEFAULT 0,
  `notifyall` tinyint(1) DEFAULT 0,
  `password` varchar(50) DEFAULT NULL,
  `cost` varchar(20) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `roleid` bigint(10) DEFAULT 0,
  `customint1` bigint(10) DEFAULT NULL,
  `customint2` bigint(10) DEFAULT NULL,
  `customint3` bigint(10) DEFAULT NULL,
  `customint4` bigint(10) DEFAULT NULL,
  `customint5` bigint(10) DEFAULT NULL,
  `customint6` bigint(10) DEFAULT NULL,
  `customint7` bigint(10) DEFAULT NULL,
  `customint8` bigint(10) DEFAULT NULL,
  `customchar1` varchar(255) DEFAULT NULL,
  `customchar2` varchar(255) DEFAULT NULL,
  `customchar3` varchar(1333) DEFAULT NULL,
  `customdec1` decimal(12,7) DEFAULT NULL,
  `customdec2` decimal(12,7) DEFAULT NULL,
  `customtext1` longtext DEFAULT NULL,
  `customtext2` longtext DEFAULT NULL,
  `customtext3` longtext DEFAULT NULL,
  `customtext4` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of enrolment plugins used in courses, fields marke';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_flatfile`
--

CREATE TABLE `mdlfx_enrol_flatfile` (
  `id` bigint(10) NOT NULL,
  `action` varchar(30) NOT NULL DEFAULT '',
  `roleid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `timestart` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='enrol_flatfile table retrofitted from MySQL';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_lti2_consumer`
--

CREATE TABLE `mdlfx_enrol_lti_lti2_consumer` (
  `id` bigint(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `consumerkey256` varchar(255) NOT NULL DEFAULT '',
  `consumerkey` longtext DEFAULT NULL,
  `secret` varchar(1024) NOT NULL DEFAULT '',
  `ltiversion` varchar(10) DEFAULT NULL,
  `consumername` varchar(255) DEFAULT NULL,
  `consumerversion` varchar(255) DEFAULT NULL,
  `consumerguid` varchar(1024) DEFAULT NULL,
  `profile` longtext DEFAULT NULL,
  `toolproxy` longtext DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `protected` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enablefrom` bigint(10) DEFAULT NULL,
  `enableuntil` bigint(10) DEFAULT NULL,
  `lastaccess` bigint(10) DEFAULT NULL,
  `created` bigint(10) NOT NULL,
  `updated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='LTI consumers interacting with moodle';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_lti2_context`
--

CREATE TABLE `mdlfx_enrol_lti_lti2_context` (
  `id` bigint(11) NOT NULL,
  `consumerid` bigint(11) NOT NULL,
  `lticontextkey` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(100) DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `created` bigint(10) NOT NULL,
  `updated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Information about a specific LTI contexts from the consumers';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_lti2_nonce`
--

CREATE TABLE `mdlfx_enrol_lti_lti2_nonce` (
  `id` bigint(11) NOT NULL,
  `consumerid` bigint(11) NOT NULL,
  `value` varchar(64) NOT NULL DEFAULT '',
  `expires` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Nonce used for authentication between moodle and a consumer';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_lti2_resource_link`
--

CREATE TABLE `mdlfx_enrol_lti_lti2_resource_link` (
  `id` bigint(11) NOT NULL,
  `contextid` bigint(11) DEFAULT NULL,
  `consumerid` bigint(11) DEFAULT NULL,
  `ltiresourcelinkkey` varchar(255) NOT NULL DEFAULT '',
  `settings` longtext DEFAULT NULL,
  `primaryresourcelinkid` bigint(11) DEFAULT NULL,
  `shareapproved` tinyint(1) DEFAULT NULL,
  `created` bigint(10) NOT NULL,
  `updated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link from the consumer to the tool';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_lti2_share_key`
--

CREATE TABLE `mdlfx_enrol_lti_lti2_share_key` (
  `id` bigint(11) NOT NULL,
  `sharekey` varchar(32) NOT NULL DEFAULT '',
  `resourcelinkid` bigint(11) NOT NULL,
  `autoapprove` tinyint(1) NOT NULL,
  `expires` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resource link share key';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_lti2_tool_proxy`
--

CREATE TABLE `mdlfx_enrol_lti_lti2_tool_proxy` (
  `id` bigint(11) NOT NULL,
  `toolproxykey` varchar(32) NOT NULL DEFAULT '',
  `consumerid` bigint(11) NOT NULL,
  `toolproxy` longtext NOT NULL,
  `created` bigint(10) NOT NULL,
  `updated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A tool proxy between moodle and a consumer';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_lti2_user_result`
--

CREATE TABLE `mdlfx_enrol_lti_lti2_user_result` (
  `id` bigint(11) NOT NULL,
  `resourcelinkid` bigint(11) NOT NULL,
  `ltiuserkey` varchar(255) NOT NULL DEFAULT '',
  `ltiresultsourcedid` varchar(1024) NOT NULL DEFAULT '',
  `created` bigint(10) NOT NULL,
  `updated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Results for each user for each resource link';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_tools`
--

CREATE TABLE `mdlfx_enrol_lti_tools` (
  `id` bigint(10) NOT NULL,
  `enrolid` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `institution` varchar(40) NOT NULL DEFAULT '',
  `lang` varchar(30) NOT NULL DEFAULT 'en',
  `timezone` varchar(100) NOT NULL DEFAULT '99',
  `maxenrolled` bigint(10) NOT NULL DEFAULT 0,
  `maildisplay` tinyint(2) NOT NULL DEFAULT 2,
  `city` varchar(120) NOT NULL DEFAULT '',
  `country` varchar(2) NOT NULL DEFAULT '',
  `gradesync` tinyint(1) NOT NULL DEFAULT 0,
  `gradesynccompletion` tinyint(1) NOT NULL DEFAULT 0,
  `membersync` tinyint(1) NOT NULL DEFAULT 0,
  `membersyncmode` tinyint(1) NOT NULL DEFAULT 0,
  `roleinstructor` bigint(10) NOT NULL,
  `rolelearner` bigint(10) NOT NULL,
  `secret` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of tools provided to the remote system';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_tool_consumer_map`
--

CREATE TABLE `mdlfx_enrol_lti_tool_consumer_map` (
  `id` bigint(10) NOT NULL,
  `toolid` bigint(11) NOT NULL,
  `consumerid` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps the published tool to tool consumers.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_lti_users`
--

CREATE TABLE `mdlfx_enrol_lti_users` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `toolid` bigint(10) NOT NULL,
  `serviceurl` longtext DEFAULT NULL,
  `sourceid` longtext DEFAULT NULL,
  `consumerkey` longtext DEFAULT NULL,
  `consumersecret` longtext DEFAULT NULL,
  `membershipsurl` longtext DEFAULT NULL,
  `membershipsid` longtext DEFAULT NULL,
  `lastgrade` decimal(10,5) DEFAULT NULL,
  `lastaccess` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User access log and gradeback data';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_enrol_paypal`
--

CREATE TABLE `mdlfx_enrol_paypal` (
  `id` bigint(10) NOT NULL,
  `business` varchar(255) NOT NULL DEFAULT '',
  `receiver_email` varchar(255) NOT NULL DEFAULT '',
  `receiver_id` varchar(255) NOT NULL DEFAULT '',
  `item_name` varchar(255) NOT NULL DEFAULT '',
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `instanceid` bigint(10) NOT NULL DEFAULT 0,
  `memo` varchar(255) NOT NULL DEFAULT '',
  `tax` varchar(255) NOT NULL DEFAULT '',
  `option_name1` varchar(255) NOT NULL DEFAULT '',
  `option_selection1_x` varchar(255) NOT NULL DEFAULT '',
  `option_name2` varchar(255) NOT NULL DEFAULT '',
  `option_selection2_x` varchar(255) NOT NULL DEFAULT '',
  `payment_status` varchar(255) NOT NULL DEFAULT '',
  `pending_reason` varchar(255) NOT NULL DEFAULT '',
  `reason_code` varchar(30) NOT NULL DEFAULT '',
  `txn_id` varchar(255) NOT NULL DEFAULT '',
  `parent_txn_id` varchar(255) NOT NULL DEFAULT '',
  `payment_type` varchar(30) NOT NULL DEFAULT '',
  `timeupdated` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds all known information about PayPal transactions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_event`
--

CREATE TABLE `mdlfx_event` (
  `id` bigint(10) NOT NULL,
  `name` longtext NOT NULL,
  `description` longtext NOT NULL,
  `format` smallint(4) NOT NULL DEFAULT 0,
  `categoryid` bigint(10) NOT NULL DEFAULT 0,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `repeatid` bigint(10) NOT NULL DEFAULT 0,
  `modulename` varchar(20) NOT NULL DEFAULT '',
  `instance` bigint(10) NOT NULL DEFAULT 0,
  `type` smallint(4) NOT NULL DEFAULT 0,
  `eventtype` varchar(20) NOT NULL DEFAULT '',
  `timestart` bigint(10) NOT NULL DEFAULT 0,
  `timeduration` bigint(10) NOT NULL DEFAULT 0,
  `timesort` bigint(10) DEFAULT NULL,
  `visible` smallint(4) NOT NULL DEFAULT 1,
  `uuid` varchar(255) NOT NULL DEFAULT '',
  `sequence` bigint(10) NOT NULL DEFAULT 1,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `subscriptionid` bigint(10) DEFAULT NULL,
  `priority` bigint(10) DEFAULT NULL,
  `location` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='For everything with a time associated to it';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_events_handlers`
--

CREATE TABLE `mdlfx_events_handlers` (
  `id` bigint(10) NOT NULL,
  `eventname` varchar(166) NOT NULL DEFAULT '',
  `component` varchar(166) NOT NULL DEFAULT '',
  `handlerfile` varchar(255) NOT NULL DEFAULT '',
  `handlerfunction` longtext DEFAULT NULL,
  `schedule` varchar(255) DEFAULT NULL,
  `status` bigint(10) NOT NULL DEFAULT 0,
  `internal` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table is for storing which components requests what typ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_events_queue`
--

CREATE TABLE `mdlfx_events_queue` (
  `id` bigint(10) NOT NULL,
  `eventdata` longtext NOT NULL,
  `stackdump` longtext DEFAULT NULL,
  `userid` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table is for storing queued events. It stores only one ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_events_queue_handlers`
--

CREATE TABLE `mdlfx_events_queue_handlers` (
  `id` bigint(10) NOT NULL,
  `queuedeventid` bigint(10) NOT NULL,
  `handlerid` bigint(10) NOT NULL,
  `status` bigint(10) DEFAULT NULL,
  `errormessage` longtext DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This is the list of queued handlers for processing. The even';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_event_subscriptions`
--

CREATE TABLE `mdlfx_event_subscriptions` (
  `id` bigint(10) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `categoryid` bigint(10) NOT NULL DEFAULT 0,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `eventtype` varchar(20) NOT NULL DEFAULT '',
  `pollinterval` bigint(10) NOT NULL DEFAULT 0,
  `lastupdated` bigint(10) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tracks subscriptions to remote calendars.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_external_functions`
--

CREATE TABLE `mdlfx_external_functions` (
  `id` bigint(10) NOT NULL,
  `name` varchar(200) NOT NULL DEFAULT '',
  `classname` varchar(100) NOT NULL DEFAULT '',
  `methodname` varchar(100) NOT NULL DEFAULT '',
  `classpath` varchar(255) DEFAULT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `capabilities` varchar(255) DEFAULT NULL,
  `services` varchar(1333) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='list of all external functions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_external_services`
--

CREATE TABLE `mdlfx_external_services` (
  `id` bigint(10) NOT NULL,
  `name` varchar(200) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL,
  `requiredcapability` varchar(150) DEFAULT NULL,
  `restrictedusers` tinyint(1) NOT NULL,
  `component` varchar(100) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `shortname` varchar(255) DEFAULT NULL,
  `downloadfiles` tinyint(1) NOT NULL DEFAULT 0,
  `uploadfiles` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='built in and custom external services';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_external_services_functions`
--

CREATE TABLE `mdlfx_external_services_functions` (
  `id` bigint(10) NOT NULL,
  `externalserviceid` bigint(10) NOT NULL,
  `functionname` varchar(200) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='lists functions available in each service group';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_external_services_users`
--

CREATE TABLE `mdlfx_external_services_users` (
  `id` bigint(10) NOT NULL,
  `externalserviceid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `iprestriction` varchar(255) DEFAULT NULL,
  `validuntil` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='users allowed to use services with restricted users flag';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_external_tokens`
--

CREATE TABLE `mdlfx_external_tokens` (
  `id` bigint(10) NOT NULL,
  `token` varchar(128) NOT NULL DEFAULT '',
  `privatetoken` varchar(64) DEFAULT NULL,
  `tokentype` smallint(4) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `externalserviceid` bigint(10) NOT NULL,
  `sid` varchar(128) DEFAULT NULL,
  `contextid` bigint(10) NOT NULL,
  `creatorid` bigint(10) NOT NULL DEFAULT 1,
  `iprestriction` varchar(255) DEFAULT NULL,
  `validuntil` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `lastaccess` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Security tokens for accessing of external services';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_favourite`
--

CREATE TABLE `mdlfx_favourite` (
  `id` bigint(10) NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `itemtype` varchar(100) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `ordering` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the relationship between an arbitrary item (itemtype,';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_feedback`
--

CREATE TABLE `mdlfx_feedback` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `anonymous` tinyint(1) NOT NULL DEFAULT 1,
  `email_notification` tinyint(1) NOT NULL DEFAULT 1,
  `multiple_submit` tinyint(1) NOT NULL DEFAULT 1,
  `autonumbering` tinyint(1) NOT NULL DEFAULT 1,
  `site_after_submit` varchar(255) NOT NULL DEFAULT '',
  `page_after_submit` longtext NOT NULL,
  `page_after_submitformat` tinyint(2) NOT NULL DEFAULT 0,
  `publish_stats` tinyint(1) NOT NULL DEFAULT 0,
  `timeopen` bigint(10) NOT NULL DEFAULT 0,
  `timeclose` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `completionsubmit` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all feedbacks';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_feedback_completed`
--

CREATE TABLE `mdlfx_feedback_completed` (
  `id` bigint(10) NOT NULL,
  `feedback` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `random_response` bigint(10) NOT NULL DEFAULT 0,
  `anonymous_response` tinyint(1) NOT NULL DEFAULT 0,
  `courseid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='filled out feedback';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_feedback_completedtmp`
--

CREATE TABLE `mdlfx_feedback_completedtmp` (
  `id` bigint(10) NOT NULL,
  `feedback` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `guestid` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `random_response` bigint(10) NOT NULL DEFAULT 0,
  `anonymous_response` tinyint(1) NOT NULL DEFAULT 0,
  `courseid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='filled out feedback';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_feedback_item`
--

CREATE TABLE `mdlfx_feedback_item` (
  `id` bigint(10) NOT NULL,
  `feedback` bigint(10) NOT NULL DEFAULT 0,
  `template` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) NOT NULL DEFAULT '',
  `presentation` longtext NOT NULL,
  `typ` varchar(255) NOT NULL DEFAULT '',
  `hasvalue` tinyint(1) NOT NULL DEFAULT 0,
  `position` smallint(3) NOT NULL DEFAULT 0,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `dependitem` bigint(10) NOT NULL DEFAULT 0,
  `dependvalue` varchar(255) NOT NULL DEFAULT '',
  `options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='feedback_items';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_feedback_sitecourse_map`
--

CREATE TABLE `mdlfx_feedback_sitecourse_map` (
  `id` bigint(10) NOT NULL,
  `feedbackid` bigint(10) NOT NULL DEFAULT 0,
  `courseid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='feedback sitecourse map';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_feedback_template`
--

CREATE TABLE `mdlfx_feedback_template` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `ispublic` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='templates of feedbackstructures';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_feedback_value`
--

CREATE TABLE `mdlfx_feedback_value` (
  `id` bigint(10) NOT NULL,
  `course_id` bigint(10) NOT NULL DEFAULT 0,
  `item` bigint(10) NOT NULL DEFAULT 0,
  `completed` bigint(10) NOT NULL DEFAULT 0,
  `tmp_completed` bigint(10) NOT NULL DEFAULT 0,
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='values of the completeds';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_feedback_valuetmp`
--

CREATE TABLE `mdlfx_feedback_valuetmp` (
  `id` bigint(10) NOT NULL,
  `course_id` bigint(10) NOT NULL DEFAULT 0,
  `item` bigint(10) NOT NULL DEFAULT 0,
  `completed` bigint(10) NOT NULL DEFAULT 0,
  `tmp_completed` bigint(10) NOT NULL DEFAULT 0,
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='values of the completedstmp';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_files`
--

CREATE TABLE `mdlfx_files` (
  `id` bigint(10) NOT NULL,
  `contenthash` varchar(40) NOT NULL DEFAULT '',
  `pathnamehash` varchar(40) NOT NULL DEFAULT '',
  `contextid` bigint(10) NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `filearea` varchar(50) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL,
  `filepath` varchar(255) NOT NULL DEFAULT '',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `userid` bigint(10) DEFAULT NULL,
  `filesize` bigint(10) NOT NULL,
  `mimetype` varchar(100) DEFAULT NULL,
  `status` bigint(10) NOT NULL DEFAULT 0,
  `source` longtext DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `referencefileid` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='description of files, content is stored in sha1 file pool';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_files_reference`
--

CREATE TABLE `mdlfx_files_reference` (
  `id` bigint(10) NOT NULL,
  `repositoryid` bigint(10) NOT NULL,
  `lastsync` bigint(10) DEFAULT NULL,
  `reference` longtext DEFAULT NULL,
  `referencehash` varchar(40) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store files references';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_file_conversion`
--

CREATE TABLE `mdlfx_file_conversion` (
  `id` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `sourcefileid` bigint(10) NOT NULL,
  `targetformat` varchar(100) NOT NULL DEFAULT '',
  `status` bigint(10) DEFAULT 0,
  `statusmessage` longtext DEFAULT NULL,
  `converter` varchar(255) DEFAULT NULL,
  `destfileid` bigint(10) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to track file conversions.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_filter_active`
--

CREATE TABLE `mdlfx_filter_active` (
  `id` bigint(10) NOT NULL,
  `filter` varchar(32) NOT NULL DEFAULT '',
  `contextid` bigint(10) NOT NULL,
  `active` smallint(4) NOT NULL,
  `sortorder` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about which filters are active in which c';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_filter_config`
--

CREATE TABLE `mdlfx_filter_config` (
  `id` bigint(10) NOT NULL,
  `filter` varchar(32) NOT NULL DEFAULT '',
  `contextid` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores per-context configuration settings for filters which ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_folder`
--

CREATE TABLE `mdlfx_folder` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `revision` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `display` smallint(4) NOT NULL DEFAULT 0,
  `showexpanded` tinyint(1) NOT NULL DEFAULT 1,
  `showdownloadfolder` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each record is one folder resource';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum`
--

CREATE TABLE `mdlfx_forum` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `type` varchar(20) NOT NULL DEFAULT 'general',
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `duedate` bigint(10) NOT NULL DEFAULT 0,
  `cutoffdate` bigint(10) NOT NULL DEFAULT 0,
  `assessed` bigint(10) NOT NULL DEFAULT 0,
  `assesstimestart` bigint(10) NOT NULL DEFAULT 0,
  `assesstimefinish` bigint(10) NOT NULL DEFAULT 0,
  `scale` bigint(10) NOT NULL DEFAULT 0,
  `grade_forum` bigint(10) NOT NULL DEFAULT 0,
  `grade_forum_notify` smallint(4) NOT NULL DEFAULT 0,
  `maxbytes` bigint(10) NOT NULL DEFAULT 0,
  `maxattachments` bigint(10) NOT NULL DEFAULT 1,
  `forcesubscribe` tinyint(1) NOT NULL DEFAULT 0,
  `trackingtype` tinyint(2) NOT NULL DEFAULT 1,
  `rsstype` tinyint(2) NOT NULL DEFAULT 0,
  `rssarticles` tinyint(2) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `warnafter` bigint(10) NOT NULL DEFAULT 0,
  `blockafter` bigint(10) NOT NULL DEFAULT 0,
  `blockperiod` bigint(10) NOT NULL DEFAULT 0,
  `completiondiscussions` int(9) NOT NULL DEFAULT 0,
  `completionreplies` int(9) NOT NULL DEFAULT 0,
  `completionposts` int(9) NOT NULL DEFAULT 0,
  `displaywordcount` tinyint(1) NOT NULL DEFAULT 0,
  `lockdiscussionafter` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forums contain and structure discussion';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_digests`
--

CREATE TABLE `mdlfx_forum_digests` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `forum` bigint(10) NOT NULL,
  `maildigest` tinyint(1) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeps track of user mail delivery preferences for each forum';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_discussions`
--

CREATE TABLE `mdlfx_forum_discussions` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `forum` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `firstpost` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT -1,
  `assessed` tinyint(1) NOT NULL DEFAULT 1,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `usermodified` bigint(10) NOT NULL DEFAULT 0,
  `timestart` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 0,
  `pinned` tinyint(1) NOT NULL DEFAULT 0,
  `timelocked` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forums are composed of discussions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_discussion_subs`
--

CREATE TABLE `mdlfx_forum_discussion_subs` (
  `id` bigint(10) NOT NULL,
  `forum` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `discussion` bigint(10) NOT NULL,
  `preference` bigint(10) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may choose to subscribe and unsubscribe from specific ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_grades`
--

CREATE TABLE `mdlfx_forum_grades` (
  `id` bigint(10) NOT NULL,
  `forum` bigint(10) NOT NULL,
  `itemnumber` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `grade` decimal(10,5) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grading data for forum instances';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_posts`
--

CREATE TABLE `mdlfx_forum_posts` (
  `id` bigint(10) NOT NULL,
  `discussion` bigint(10) NOT NULL DEFAULT 0,
  `parent` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `created` bigint(10) NOT NULL DEFAULT 0,
  `modified` bigint(10) NOT NULL DEFAULT 0,
  `mailed` tinyint(2) NOT NULL DEFAULT 0,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` longtext NOT NULL,
  `messageformat` tinyint(2) NOT NULL DEFAULT 0,
  `messagetrust` tinyint(2) NOT NULL DEFAULT 0,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `totalscore` smallint(4) NOT NULL DEFAULT 0,
  `mailnow` bigint(10) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `privatereplyto` bigint(10) NOT NULL DEFAULT 0,
  `wordcount` bigint(20) DEFAULT NULL,
  `charcount` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All posts are stored in this table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_queue`
--

CREATE TABLE `mdlfx_forum_queue` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `discussionid` bigint(10) NOT NULL DEFAULT 0,
  `postid` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='For keeping track of posts that will be mailed in digest for';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_read`
--

CREATE TABLE `mdlfx_forum_read` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `forumid` bigint(10) NOT NULL DEFAULT 0,
  `discussionid` bigint(10) NOT NULL DEFAULT 0,
  `postid` bigint(10) NOT NULL DEFAULT 0,
  `firstread` bigint(10) NOT NULL DEFAULT 0,
  `lastread` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tracks each users read posts';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_subscriptions`
--

CREATE TABLE `mdlfx_forum_subscriptions` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `forum` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeps track of who is subscribed to what forum';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_forum_track_prefs`
--

CREATE TABLE `mdlfx_forum_track_prefs` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `forumid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tracks each users untracked forums';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_glossary`
--

CREATE TABLE `mdlfx_glossary` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `allowduplicatedentries` tinyint(2) NOT NULL DEFAULT 0,
  `displayformat` varchar(50) NOT NULL DEFAULT 'dictionary',
  `mainglossary` tinyint(2) NOT NULL DEFAULT 0,
  `showspecial` tinyint(2) NOT NULL DEFAULT 1,
  `showalphabet` tinyint(2) NOT NULL DEFAULT 1,
  `showall` tinyint(2) NOT NULL DEFAULT 1,
  `allowcomments` tinyint(2) NOT NULL DEFAULT 0,
  `allowprintview` tinyint(2) NOT NULL DEFAULT 1,
  `usedynalink` tinyint(2) NOT NULL DEFAULT 1,
  `defaultapproval` tinyint(2) NOT NULL DEFAULT 1,
  `approvaldisplayformat` varchar(50) NOT NULL DEFAULT 'default',
  `globalglossary` tinyint(2) NOT NULL DEFAULT 0,
  `entbypage` smallint(3) NOT NULL DEFAULT 10,
  `editalways` tinyint(2) NOT NULL DEFAULT 0,
  `rsstype` tinyint(2) NOT NULL DEFAULT 0,
  `rssarticles` tinyint(2) NOT NULL DEFAULT 0,
  `assessed` bigint(10) NOT NULL DEFAULT 0,
  `assesstimestart` bigint(10) NOT NULL DEFAULT 0,
  `assesstimefinish` bigint(10) NOT NULL DEFAULT 0,
  `scale` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `completionentries` int(9) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all glossaries';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_glossary_alias`
--

CREATE TABLE `mdlfx_glossary_alias` (
  `id` bigint(10) NOT NULL,
  `entryid` bigint(10) NOT NULL DEFAULT 0,
  `alias` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='entries alias';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_glossary_categories`
--

CREATE TABLE `mdlfx_glossary_categories` (
  `id` bigint(10) NOT NULL,
  `glossaryid` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `usedynalink` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all categories for glossary entries';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_glossary_entries`
--

CREATE TABLE `mdlfx_glossary_entries` (
  `id` bigint(10) NOT NULL,
  `glossaryid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `concept` varchar(255) NOT NULL DEFAULT '',
  `definition` longtext NOT NULL,
  `definitionformat` tinyint(2) NOT NULL DEFAULT 0,
  `definitiontrust` tinyint(2) NOT NULL DEFAULT 0,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `teacherentry` tinyint(2) NOT NULL DEFAULT 0,
  `sourceglossaryid` bigint(10) NOT NULL DEFAULT 0,
  `usedynalink` tinyint(2) NOT NULL DEFAULT 1,
  `casesensitive` tinyint(2) NOT NULL DEFAULT 0,
  `fullmatch` tinyint(2) NOT NULL DEFAULT 1,
  `approved` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='all glossary entries';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_glossary_entries_categories`
--

CREATE TABLE `mdlfx_glossary_entries_categories` (
  `id` bigint(10) NOT NULL,
  `categoryid` bigint(10) NOT NULL DEFAULT 0,
  `entryid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='categories of each glossary entry';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_glossary_formats`
--

CREATE TABLE `mdlfx_glossary_formats` (
  `id` bigint(10) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `popupformatname` varchar(50) NOT NULL DEFAULT '',
  `visible` tinyint(2) NOT NULL DEFAULT 1,
  `showgroup` tinyint(2) NOT NULL DEFAULT 1,
  `showtabs` varchar(100) DEFAULT NULL,
  `defaultmode` varchar(50) NOT NULL DEFAULT '',
  `defaulthook` varchar(50) NOT NULL DEFAULT '',
  `sortkey` varchar(50) NOT NULL DEFAULT '',
  `sortorder` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Setting of the display formats';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_categories`
--

CREATE TABLE `mdlfx_grade_categories` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `parent` bigint(10) DEFAULT NULL,
  `depth` bigint(10) NOT NULL DEFAULT 0,
  `path` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) NOT NULL DEFAULT '',
  `aggregation` bigint(10) NOT NULL DEFAULT 0,
  `keephigh` bigint(10) NOT NULL DEFAULT 0,
  `droplow` bigint(10) NOT NULL DEFAULT 0,
  `aggregateonlygraded` tinyint(1) NOT NULL DEFAULT 0,
  `aggregateoutcomes` tinyint(1) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table keeps information about categories, used for grou';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_categories_history`
--

CREATE TABLE `mdlfx_grade_categories_history` (
  `id` bigint(10) NOT NULL,
  `action` bigint(10) NOT NULL DEFAULT 0,
  `oldid` bigint(10) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `loggeduser` bigint(10) DEFAULT NULL,
  `courseid` bigint(10) NOT NULL,
  `parent` bigint(10) DEFAULT NULL,
  `depth` bigint(10) NOT NULL DEFAULT 0,
  `path` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) NOT NULL DEFAULT '',
  `aggregation` bigint(10) NOT NULL DEFAULT 0,
  `keephigh` bigint(10) NOT NULL DEFAULT 0,
  `droplow` bigint(10) NOT NULL DEFAULT 0,
  `aggregateonlygraded` tinyint(1) NOT NULL DEFAULT 0,
  `aggregateoutcomes` tinyint(1) NOT NULL DEFAULT 0,
  `aggregatesubcats` tinyint(1) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History of grade_categories';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_grades`
--

CREATE TABLE `mdlfx_grade_grades` (
  `id` bigint(10) NOT NULL,
  `itemid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `rawgrade` decimal(10,5) DEFAULT NULL,
  `rawgrademax` decimal(10,5) NOT NULL DEFAULT 100.00000,
  `rawgrademin` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `rawscaleid` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) DEFAULT NULL,
  `finalgrade` decimal(10,5) DEFAULT NULL,
  `hidden` bigint(10) NOT NULL DEFAULT 0,
  `locked` bigint(10) NOT NULL DEFAULT 0,
  `locktime` bigint(10) NOT NULL DEFAULT 0,
  `exported` bigint(10) NOT NULL DEFAULT 0,
  `overridden` bigint(10) NOT NULL DEFAULT 0,
  `excluded` bigint(10) NOT NULL DEFAULT 0,
  `feedback` longtext DEFAULT NULL,
  `feedbackformat` bigint(10) NOT NULL DEFAULT 0,
  `information` longtext DEFAULT NULL,
  `informationformat` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `aggregationstatus` varchar(10) NOT NULL DEFAULT 'unknown',
  `aggregationweight` decimal(10,5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='grade_grades  This table keeps individual grades for each us';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_grades_history`
--

CREATE TABLE `mdlfx_grade_grades_history` (
  `id` bigint(10) NOT NULL,
  `action` bigint(10) NOT NULL DEFAULT 0,
  `oldid` bigint(10) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `loggeduser` bigint(10) DEFAULT NULL,
  `itemid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `rawgrade` decimal(10,5) DEFAULT NULL,
  `rawgrademax` decimal(10,5) NOT NULL DEFAULT 100.00000,
  `rawgrademin` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `rawscaleid` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) DEFAULT NULL,
  `finalgrade` decimal(10,5) DEFAULT NULL,
  `hidden` bigint(10) NOT NULL DEFAULT 0,
  `locked` bigint(10) NOT NULL DEFAULT 0,
  `locktime` bigint(10) NOT NULL DEFAULT 0,
  `exported` bigint(10) NOT NULL DEFAULT 0,
  `overridden` bigint(10) NOT NULL DEFAULT 0,
  `excluded` bigint(10) NOT NULL DEFAULT 0,
  `feedback` longtext DEFAULT NULL,
  `feedbackformat` bigint(10) NOT NULL DEFAULT 0,
  `information` longtext DEFAULT NULL,
  `informationformat` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_import_newitem`
--

CREATE TABLE `mdlfx_grade_import_newitem` (
  `id` bigint(10) NOT NULL,
  `itemname` varchar(255) NOT NULL DEFAULT '',
  `importcode` bigint(10) NOT NULL,
  `importer` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='temporary table for storing new grade_item names from grade ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_import_values`
--

CREATE TABLE `mdlfx_grade_import_values` (
  `id` bigint(10) NOT NULL,
  `itemid` bigint(10) DEFAULT NULL,
  `newgradeitem` bigint(10) DEFAULT NULL,
  `userid` bigint(10) NOT NULL,
  `finalgrade` decimal(10,5) DEFAULT NULL,
  `feedback` longtext DEFAULT NULL,
  `importcode` bigint(10) NOT NULL,
  `importer` bigint(10) DEFAULT NULL,
  `importonlyfeedback` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Temporary table for importing grades';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_items`
--

CREATE TABLE `mdlfx_grade_items` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) DEFAULT NULL,
  `categoryid` bigint(10) DEFAULT NULL,
  `itemname` varchar(255) DEFAULT NULL,
  `itemtype` varchar(30) NOT NULL DEFAULT '',
  `itemmodule` varchar(30) DEFAULT NULL,
  `iteminstance` bigint(10) DEFAULT NULL,
  `itemnumber` bigint(10) DEFAULT NULL,
  `iteminfo` longtext DEFAULT NULL,
  `idnumber` varchar(255) DEFAULT NULL,
  `calculation` longtext DEFAULT NULL,
  `gradetype` smallint(4) NOT NULL DEFAULT 1,
  `grademax` decimal(10,5) NOT NULL DEFAULT 100.00000,
  `grademin` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `scaleid` bigint(10) DEFAULT NULL,
  `outcomeid` bigint(10) DEFAULT NULL,
  `gradepass` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `multfactor` decimal(10,5) NOT NULL DEFAULT 1.00000,
  `plusfactor` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `aggregationcoef` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `aggregationcoef2` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `display` bigint(10) NOT NULL DEFAULT 0,
  `decimals` tinyint(1) DEFAULT NULL,
  `hidden` bigint(10) NOT NULL DEFAULT 0,
  `locked` bigint(10) NOT NULL DEFAULT 0,
  `locktime` bigint(10) NOT NULL DEFAULT 0,
  `needsupdate` bigint(10) NOT NULL DEFAULT 0,
  `weightoverride` tinyint(1) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table keeps information about gradeable items (ie colum';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_items_history`
--

CREATE TABLE `mdlfx_grade_items_history` (
  `id` bigint(10) NOT NULL,
  `action` bigint(10) NOT NULL DEFAULT 0,
  `oldid` bigint(10) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `loggeduser` bigint(10) DEFAULT NULL,
  `courseid` bigint(10) DEFAULT NULL,
  `categoryid` bigint(10) DEFAULT NULL,
  `itemname` varchar(255) DEFAULT NULL,
  `itemtype` varchar(30) NOT NULL DEFAULT '',
  `itemmodule` varchar(30) DEFAULT NULL,
  `iteminstance` bigint(10) DEFAULT NULL,
  `itemnumber` bigint(10) DEFAULT NULL,
  `iteminfo` longtext DEFAULT NULL,
  `idnumber` varchar(255) DEFAULT NULL,
  `calculation` longtext DEFAULT NULL,
  `gradetype` smallint(4) NOT NULL DEFAULT 1,
  `grademax` decimal(10,5) NOT NULL DEFAULT 100.00000,
  `grademin` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `scaleid` bigint(10) DEFAULT NULL,
  `outcomeid` bigint(10) DEFAULT NULL,
  `gradepass` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `multfactor` decimal(10,5) NOT NULL DEFAULT 1.00000,
  `plusfactor` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `aggregationcoef` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `aggregationcoef2` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `hidden` bigint(10) NOT NULL DEFAULT 0,
  `locked` bigint(10) NOT NULL DEFAULT 0,
  `locktime` bigint(10) NOT NULL DEFAULT 0,
  `needsupdate` bigint(10) NOT NULL DEFAULT 0,
  `display` bigint(10) NOT NULL DEFAULT 0,
  `decimals` tinyint(1) DEFAULT NULL,
  `weightoverride` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History of grade_items';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_letters`
--

CREATE TABLE `mdlfx_grade_letters` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `lowerboundary` decimal(10,5) NOT NULL,
  `letter` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Repository for grade letters, for courses and other moodle e';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_outcomes`
--

CREATE TABLE `mdlfx_grade_outcomes` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) DEFAULT NULL,
  `shortname` varchar(255) NOT NULL DEFAULT '',
  `fullname` longtext NOT NULL,
  `scaleid` bigint(10) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table describes the outcomes used in the system. An out';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_outcomes_courses`
--

CREATE TABLE `mdlfx_grade_outcomes_courses` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `outcomeid` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores what outcomes are used in what courses.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_outcomes_history`
--

CREATE TABLE `mdlfx_grade_outcomes_history` (
  `id` bigint(10) NOT NULL,
  `action` bigint(10) NOT NULL DEFAULT 0,
  `oldid` bigint(10) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `loggeduser` bigint(10) DEFAULT NULL,
  `courseid` bigint(10) DEFAULT NULL,
  `shortname` varchar(255) NOT NULL DEFAULT '',
  `fullname` longtext NOT NULL,
  `scaleid` bigint(10) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grade_settings`
--

CREATE TABLE `mdlfx_grade_settings` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='gradebook settings';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_gradingform_guide_comments`
--

CREATE TABLE `mdlfx_gradingform_guide_comments` (
  `id` bigint(10) NOT NULL,
  `definitionid` bigint(10) NOT NULL,
  `sortorder` bigint(10) NOT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='frequently used comments used in marking guide';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_gradingform_guide_criteria`
--

CREATE TABLE `mdlfx_gradingform_guide_criteria` (
  `id` bigint(10) NOT NULL,
  `definitionid` bigint(10) NOT NULL,
  `sortorder` bigint(10) NOT NULL,
  `shortname` varchar(255) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) DEFAULT NULL,
  `descriptionmarkers` longtext DEFAULT NULL,
  `descriptionmarkersformat` tinyint(2) DEFAULT NULL,
  `maxscore` decimal(10,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the rows of the criteria grid.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_gradingform_guide_fillings`
--

CREATE TABLE `mdlfx_gradingform_guide_fillings` (
  `id` bigint(10) NOT NULL,
  `instanceid` bigint(10) NOT NULL,
  `criterionid` bigint(10) NOT NULL,
  `remark` longtext DEFAULT NULL,
  `remarkformat` tinyint(2) DEFAULT NULL,
  `score` decimal(10,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the data of how the guide is filled by a particular r';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_gradingform_rubric_criteria`
--

CREATE TABLE `mdlfx_gradingform_rubric_criteria` (
  `id` bigint(10) NOT NULL,
  `definitionid` bigint(10) NOT NULL,
  `sortorder` bigint(10) NOT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the rows of the rubric grid.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_gradingform_rubric_fillings`
--

CREATE TABLE `mdlfx_gradingform_rubric_fillings` (
  `id` bigint(10) NOT NULL,
  `instanceid` bigint(10) NOT NULL,
  `criterionid` bigint(10) NOT NULL,
  `levelid` bigint(10) DEFAULT NULL,
  `remark` longtext DEFAULT NULL,
  `remarkformat` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the data of how the rubric is filled by a particular ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_gradingform_rubric_levels`
--

CREATE TABLE `mdlfx_gradingform_rubric_levels` (
  `id` bigint(10) NOT NULL,
  `criterionid` bigint(10) NOT NULL,
  `score` decimal(10,5) NOT NULL,
  `definition` longtext DEFAULT NULL,
  `definitionformat` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the columns of the rubric grid.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grading_areas`
--

CREATE TABLE `mdlfx_grading_areas` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `areaname` varchar(100) NOT NULL DEFAULT '',
  `activemethod` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies gradable areas where advanced grading can happen.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grading_definitions`
--

CREATE TABLE `mdlfx_grading_definitions` (
  `id` bigint(10) NOT NULL,
  `areaid` bigint(10) NOT NULL,
  `method` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) DEFAULT NULL,
  `status` bigint(10) NOT NULL DEFAULT 0,
  `copiedfromid` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `usercreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `timecopied` bigint(10) DEFAULT 0,
  `options` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the basic information about an advanced grading for';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_grading_instances`
--

CREATE TABLE `mdlfx_grading_instances` (
  `id` bigint(10) NOT NULL,
  `definitionid` bigint(10) NOT NULL,
  `raterid` bigint(10) NOT NULL,
  `itemid` bigint(10) DEFAULT NULL,
  `rawgrade` decimal(10,5) DEFAULT NULL,
  `status` bigint(10) NOT NULL DEFAULT 0,
  `feedback` longtext DEFAULT NULL,
  `feedbackformat` tinyint(2) DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grading form instance is an assessment record for one gradab';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_groupings`
--

CREATE TABLE `mdlfx_groupings` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `idnumber` varchar(100) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0,
  `configdata` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A grouping is a collection of groups. WAS: groups_groupings';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_groupings_groups`
--

CREATE TABLE `mdlfx_groupings_groups` (
  `id` bigint(10) NOT NULL,
  `groupingid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `timeadded` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a grouping to a group (note, groups can be in multiple ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_groups`
--

CREATE TABLE `mdlfx_groups` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `idnumber` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(254) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0,
  `enrolmentkey` varchar(50) DEFAULT NULL,
  `picture` bigint(10) NOT NULL DEFAULT 0,
  `hidepicture` tinyint(1) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record represents a group.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_groups_members`
--

CREATE TABLE `mdlfx_groups_members` (
  `id` bigint(10) NOT NULL,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `timeadded` bigint(10) NOT NULL DEFAULT 0,
  `component` varchar(100) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link a user to a group.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_h5p`
--

CREATE TABLE `mdlfx_h5p` (
  `id` bigint(10) NOT NULL,
  `jsoncontent` longtext NOT NULL,
  `mainlibraryid` bigint(10) NOT NULL,
  `displayoptions` smallint(4) DEFAULT NULL,
  `pathnamehash` varchar(40) NOT NULL DEFAULT '',
  `contenthash` varchar(40) NOT NULL DEFAULT '',
  `filtered` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores H5P content information';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_h5p_contents_libraries`
--

CREATE TABLE `mdlfx_h5p_contents_libraries` (
  `id` bigint(10) NOT NULL,
  `h5pid` bigint(10) NOT NULL,
  `libraryid` bigint(10) NOT NULL,
  `dependencytype` varchar(10) NOT NULL DEFAULT '',
  `dropcss` tinyint(1) NOT NULL,
  `weight` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store which library is used in which content.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_h5p_libraries`
--

CREATE TABLE `mdlfx_h5p_libraries` (
  `id` bigint(10) NOT NULL,
  `machinename` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `majorversion` smallint(4) NOT NULL,
  `minorversion` smallint(4) NOT NULL,
  `patchversion` smallint(4) NOT NULL,
  `runnable` tinyint(1) NOT NULL,
  `fullscreen` tinyint(1) NOT NULL DEFAULT 0,
  `embedtypes` varchar(255) NOT NULL DEFAULT '',
  `preloadedjs` longtext DEFAULT NULL,
  `preloadedcss` longtext DEFAULT NULL,
  `droplibrarycss` longtext DEFAULT NULL,
  `semantics` longtext DEFAULT NULL,
  `addto` longtext DEFAULT NULL,
  `coremajor` smallint(4) DEFAULT NULL,
  `coreminor` smallint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about libraries used by H5P content.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_h5p_libraries_cachedassets`
--

CREATE TABLE `mdlfx_h5p_libraries_cachedassets` (
  `id` bigint(10) NOT NULL,
  `libraryid` bigint(10) NOT NULL,
  `hash` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='H5P cached library assets';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_h5p_library_dependencies`
--

CREATE TABLE `mdlfx_h5p_library_dependencies` (
  `id` bigint(10) NOT NULL,
  `libraryid` bigint(10) NOT NULL,
  `requiredlibraryid` bigint(10) NOT NULL,
  `dependencytype` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores H5P library dependencies';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_imscp`
--

CREATE TABLE `mdlfx_imscp` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `revision` bigint(10) NOT NULL DEFAULT 0,
  `keepold` bigint(10) NOT NULL DEFAULT -1,
  `structure` longtext DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each record is one imscp resource';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_label`
--

CREATE TABLE `mdlfx_label` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines labels';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lesson`
--

CREATE TABLE `mdlfx_lesson` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `practice` smallint(3) NOT NULL DEFAULT 0,
  `modattempts` smallint(3) NOT NULL DEFAULT 0,
  `usepassword` smallint(3) NOT NULL DEFAULT 0,
  `password` varchar(32) NOT NULL DEFAULT '',
  `dependency` bigint(10) NOT NULL DEFAULT 0,
  `conditions` longtext NOT NULL,
  `grade` bigint(10) NOT NULL DEFAULT 0,
  `custom` smallint(3) NOT NULL DEFAULT 0,
  `ongoing` smallint(3) NOT NULL DEFAULT 0,
  `usemaxgrade` smallint(3) NOT NULL DEFAULT 0,
  `maxanswers` smallint(3) NOT NULL DEFAULT 4,
  `maxattempts` smallint(3) NOT NULL DEFAULT 5,
  `review` smallint(3) NOT NULL DEFAULT 0,
  `nextpagedefault` smallint(3) NOT NULL DEFAULT 0,
  `feedback` smallint(3) NOT NULL DEFAULT 1,
  `minquestions` smallint(3) NOT NULL DEFAULT 0,
  `maxpages` smallint(3) NOT NULL DEFAULT 0,
  `timelimit` bigint(10) NOT NULL DEFAULT 0,
  `retake` smallint(3) NOT NULL DEFAULT 1,
  `activitylink` bigint(10) NOT NULL DEFAULT 0,
  `mediafile` varchar(255) NOT NULL DEFAULT '',
  `mediaheight` bigint(10) NOT NULL DEFAULT 100,
  `mediawidth` bigint(10) NOT NULL DEFAULT 650,
  `mediaclose` smallint(3) NOT NULL DEFAULT 0,
  `slideshow` smallint(3) NOT NULL DEFAULT 0,
  `width` bigint(10) NOT NULL DEFAULT 640,
  `height` bigint(10) NOT NULL DEFAULT 480,
  `bgcolor` varchar(7) NOT NULL DEFAULT '#FFFFFF',
  `displayleft` smallint(3) NOT NULL DEFAULT 0,
  `displayleftif` smallint(3) NOT NULL DEFAULT 0,
  `progressbar` smallint(3) NOT NULL DEFAULT 0,
  `available` bigint(10) NOT NULL DEFAULT 0,
  `deadline` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `completionendreached` tinyint(1) DEFAULT 0,
  `completiontimespent` bigint(11) DEFAULT 0,
  `allowofflineattempts` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lesson_answers`
--

CREATE TABLE `mdlfx_lesson_answers` (
  `id` bigint(10) NOT NULL,
  `lessonid` bigint(10) NOT NULL DEFAULT 0,
  `pageid` bigint(10) NOT NULL DEFAULT 0,
  `jumpto` bigint(11) NOT NULL DEFAULT 0,
  `grade` smallint(4) NOT NULL DEFAULT 0,
  `score` bigint(10) NOT NULL DEFAULT 0,
  `flags` smallint(3) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `answer` longtext DEFAULT NULL,
  `answerformat` tinyint(2) NOT NULL DEFAULT 0,
  `response` longtext DEFAULT NULL,
  `responseformat` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson_answers';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lesson_attempts`
--

CREATE TABLE `mdlfx_lesson_attempts` (
  `id` bigint(10) NOT NULL,
  `lessonid` bigint(10) NOT NULL DEFAULT 0,
  `pageid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `answerid` bigint(10) NOT NULL DEFAULT 0,
  `retry` smallint(3) NOT NULL DEFAULT 0,
  `correct` bigint(10) NOT NULL DEFAULT 0,
  `useranswer` longtext DEFAULT NULL,
  `timeseen` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson_attempts';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lesson_branch`
--

CREATE TABLE `mdlfx_lesson_branch` (
  `id` bigint(10) NOT NULL,
  `lessonid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `pageid` bigint(10) NOT NULL DEFAULT 0,
  `retry` bigint(10) NOT NULL DEFAULT 0,
  `flag` smallint(3) NOT NULL DEFAULT 0,
  `timeseen` bigint(10) NOT NULL DEFAULT 0,
  `nextpageid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='branches for each lesson/user';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lesson_grades`
--

CREATE TABLE `mdlfx_lesson_grades` (
  `id` bigint(10) NOT NULL,
  `lessonid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `grade` double NOT NULL DEFAULT 0,
  `late` smallint(3) NOT NULL DEFAULT 0,
  `completed` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson_grades';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lesson_overrides`
--

CREATE TABLE `mdlfx_lesson_overrides` (
  `id` bigint(10) NOT NULL,
  `lessonid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) DEFAULT NULL,
  `userid` bigint(10) DEFAULT NULL,
  `available` bigint(10) DEFAULT NULL,
  `deadline` bigint(10) DEFAULT NULL,
  `timelimit` bigint(10) DEFAULT NULL,
  `review` smallint(3) DEFAULT NULL,
  `maxattempts` smallint(3) DEFAULT NULL,
  `retake` smallint(3) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The overrides to lesson settings.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lesson_pages`
--

CREATE TABLE `mdlfx_lesson_pages` (
  `id` bigint(10) NOT NULL,
  `lessonid` bigint(10) NOT NULL DEFAULT 0,
  `prevpageid` bigint(10) NOT NULL DEFAULT 0,
  `nextpageid` bigint(10) NOT NULL DEFAULT 0,
  `qtype` smallint(3) NOT NULL DEFAULT 0,
  `qoption` smallint(3) NOT NULL DEFAULT 0,
  `layout` smallint(3) NOT NULL DEFAULT 1,
  `display` smallint(3) NOT NULL DEFAULT 1,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL DEFAULT '',
  `contents` longtext NOT NULL,
  `contentsformat` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines lesson_pages';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lesson_timer`
--

CREATE TABLE `mdlfx_lesson_timer` (
  `id` bigint(10) NOT NULL,
  `lessonid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `starttime` bigint(10) NOT NULL DEFAULT 0,
  `lessontime` bigint(10) NOT NULL DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `timemodifiedoffline` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='lesson timer for each lesson';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_license`
--

CREATE TABLE `mdlfx_license` (
  `id` bigint(10) NOT NULL,
  `shortname` varchar(255) DEFAULT NULL,
  `fullname` longtext DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `version` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='store licenses used by moodle';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lock_db`
--

CREATE TABLE `mdlfx_lock_db` (
  `id` bigint(10) NOT NULL,
  `resourcekey` varchar(255) NOT NULL DEFAULT '',
  `expires` bigint(10) DEFAULT NULL,
  `owner` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores active and inactive lock types for db locking method.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_log`
--

CREATE TABLE `mdlfx_log` (
  `id` bigint(10) NOT NULL,
  `time` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `ip` varchar(45) NOT NULL DEFAULT '',
  `course` bigint(10) NOT NULL DEFAULT 0,
  `module` varchar(20) NOT NULL DEFAULT '',
  `cmid` bigint(10) NOT NULL DEFAULT 0,
  `action` varchar(40) NOT NULL DEFAULT '',
  `url` varchar(100) NOT NULL DEFAULT '',
  `info` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Every action is logged as far as possible';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_logstore_standard_log`
--

CREATE TABLE `mdlfx_logstore_standard_log` (
  `id` bigint(10) NOT NULL,
  `eventname` varchar(255) NOT NULL DEFAULT '',
  `component` varchar(100) NOT NULL DEFAULT '',
  `action` varchar(100) NOT NULL DEFAULT '',
  `target` varchar(100) NOT NULL DEFAULT '',
  `objecttable` varchar(50) DEFAULT NULL,
  `objectid` bigint(10) DEFAULT NULL,
  `crud` varchar(1) NOT NULL DEFAULT '',
  `edulevel` tinyint(1) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `contextlevel` bigint(10) NOT NULL,
  `contextinstanceid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `courseid` bigint(10) DEFAULT NULL,
  `relateduserid` bigint(10) DEFAULT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT 0,
  `other` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `origin` varchar(10) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `realuserid` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Standard log table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_log_display`
--

CREATE TABLE `mdlfx_log_display` (
  `id` bigint(10) NOT NULL,
  `module` varchar(20) NOT NULL DEFAULT '',
  `action` varchar(40) NOT NULL DEFAULT '',
  `mtable` varchar(30) NOT NULL DEFAULT '',
  `field` varchar(200) NOT NULL DEFAULT '',
  `component` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='For a particular module/action, specifies a moodle table/fie';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_log_queries`
--

CREATE TABLE `mdlfx_log_queries` (
  `id` bigint(10) NOT NULL,
  `qtype` mediumint(5) NOT NULL,
  `sqltext` longtext NOT NULL,
  `sqlparams` longtext DEFAULT NULL,
  `error` mediumint(5) NOT NULL DEFAULT 0,
  `info` longtext DEFAULT NULL,
  `backtrace` longtext DEFAULT NULL,
  `exectime` decimal(10,5) NOT NULL,
  `timelogged` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Logged database queries.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lti`
--

CREATE TABLE `mdlfx_lti` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `typeid` bigint(10) DEFAULT NULL,
  `toolurl` longtext NOT NULL,
  `securetoolurl` longtext DEFAULT NULL,
  `instructorchoicesendname` tinyint(1) DEFAULT NULL,
  `instructorchoicesendemailaddr` tinyint(1) DEFAULT NULL,
  `instructorchoiceallowroster` tinyint(1) DEFAULT NULL,
  `instructorchoiceallowsetting` tinyint(1) DEFAULT NULL,
  `instructorcustomparameters` varchar(255) DEFAULT NULL,
  `instructorchoiceacceptgrades` tinyint(1) DEFAULT NULL,
  `grade` bigint(10) NOT NULL DEFAULT 100,
  `launchcontainer` tinyint(2) NOT NULL DEFAULT 1,
  `resourcekey` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `debuglaunch` tinyint(1) NOT NULL DEFAULT 0,
  `showtitlelaunch` tinyint(1) NOT NULL DEFAULT 0,
  `showdescriptionlaunch` tinyint(1) NOT NULL DEFAULT 0,
  `servicesalt` varchar(40) DEFAULT NULL,
  `icon` longtext DEFAULT NULL,
  `secureicon` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table contains Basic LTI activities instances';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_ltiservice_gradebookservices`
--

CREATE TABLE `mdlfx_ltiservice_gradebookservices` (
  `id` bigint(10) NOT NULL,
  `gradeitemid` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `toolproxyid` bigint(10) DEFAULT NULL,
  `typeid` bigint(10) DEFAULT NULL,
  `baseurl` longtext DEFAULT NULL,
  `ltilinkid` bigint(10) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This file records the grade items created by the LTI Gradebo';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lti_access_tokens`
--

CREATE TABLE `mdlfx_lti_access_tokens` (
  `id` bigint(10) NOT NULL,
  `typeid` bigint(10) NOT NULL,
  `scope` longtext NOT NULL,
  `token` varchar(128) NOT NULL DEFAULT '',
  `validuntil` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `lastaccess` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Security tokens for accessing of LTI services';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lti_submission`
--

CREATE TABLE `mdlfx_lti_submission` (
  `id` bigint(10) NOT NULL,
  `ltiid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `datesubmitted` bigint(10) NOT NULL,
  `dateupdated` bigint(10) NOT NULL,
  `gradepercent` decimal(10,5) NOT NULL,
  `originalgrade` decimal(10,5) NOT NULL,
  `launchid` bigint(10) NOT NULL,
  `state` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeps track of individual submissions for LTI activities.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lti_tool_proxies`
--

CREATE TABLE `mdlfx_lti_tool_proxies` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Tool Provider',
  `regurl` longtext DEFAULT NULL,
  `state` tinyint(2) NOT NULL DEFAULT 1,
  `guid` varchar(255) DEFAULT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `vendorcode` varchar(255) DEFAULT NULL,
  `capabilityoffered` longtext NOT NULL,
  `serviceoffered` longtext NOT NULL,
  `toolproxy` longtext DEFAULT NULL,
  `createdby` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='LTI tool proxy registrations';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lti_tool_settings`
--

CREATE TABLE `mdlfx_lti_tool_settings` (
  `id` bigint(10) NOT NULL,
  `toolproxyid` bigint(10) NOT NULL,
  `typeid` bigint(10) DEFAULT NULL,
  `course` bigint(10) DEFAULT NULL,
  `coursemoduleid` bigint(10) DEFAULT NULL,
  `settings` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='LTI tool setting values';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lti_types`
--

CREATE TABLE `mdlfx_lti_types` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'basiclti Activity',
  `baseurl` longtext NOT NULL,
  `tooldomain` varchar(255) NOT NULL DEFAULT '',
  `state` tinyint(2) NOT NULL DEFAULT 2,
  `course` bigint(10) NOT NULL,
  `coursevisible` tinyint(1) NOT NULL DEFAULT 0,
  `ltiversion` varchar(10) NOT NULL DEFAULT '',
  `clientid` varchar(255) DEFAULT NULL,
  `toolproxyid` bigint(10) DEFAULT NULL,
  `enabledcapability` longtext DEFAULT NULL,
  `parameter` longtext DEFAULT NULL,
  `icon` longtext DEFAULT NULL,
  `secureicon` longtext DEFAULT NULL,
  `createdby` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Basic LTI pre-configured activities';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_lti_types_config`
--

CREATE TABLE `mdlfx_lti_types_config` (
  `id` bigint(10) NOT NULL,
  `typeid` bigint(10) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Basic LTI types configuration';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message`
--

CREATE TABLE `mdlfx_message` (
  `id` bigint(10) NOT NULL,
  `useridfrom` bigint(10) NOT NULL DEFAULT 0,
  `useridto` bigint(10) NOT NULL DEFAULT 0,
  `subject` longtext DEFAULT NULL,
  `fullmessage` longtext DEFAULT NULL,
  `fullmessageformat` smallint(4) DEFAULT 0,
  `fullmessagehtml` longtext DEFAULT NULL,
  `smallmessage` longtext DEFAULT NULL,
  `notification` tinyint(1) DEFAULT 0,
  `contexturl` longtext DEFAULT NULL,
  `contexturlname` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timeuserfromdeleted` bigint(10) NOT NULL DEFAULT 0,
  `timeusertodeleted` bigint(10) NOT NULL DEFAULT 0,
  `component` varchar(100) DEFAULT NULL,
  `eventtype` varchar(100) DEFAULT NULL,
  `customdata` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all unread messages';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_messageinbound_datakeys`
--

CREATE TABLE `mdlfx_messageinbound_datakeys` (
  `id` bigint(10) NOT NULL,
  `handler` bigint(10) NOT NULL,
  `datavalue` bigint(10) NOT NULL,
  `datakey` varchar(64) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `expires` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Inbound Message data item secret keys.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_messageinbound_handlers`
--

CREATE TABLE `mdlfx_messageinbound_handlers` (
  `id` bigint(10) NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `classname` varchar(255) NOT NULL DEFAULT '',
  `defaultexpiration` bigint(10) NOT NULL DEFAULT 86400,
  `validateaddress` tinyint(1) NOT NULL DEFAULT 1,
  `enabled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Inbound Message Handler definitions.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_messageinbound_messagelist`
--

CREATE TABLE `mdlfx_messageinbound_messagelist` (
  `id` bigint(10) NOT NULL,
  `messageid` longtext NOT NULL,
  `userid` bigint(10) NOT NULL,
  `address` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of message IDs for existing replies';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_messages`
--

CREATE TABLE `mdlfx_messages` (
  `id` bigint(10) NOT NULL,
  `useridfrom` bigint(10) NOT NULL,
  `conversationid` bigint(10) NOT NULL,
  `subject` longtext DEFAULT NULL,
  `fullmessage` longtext DEFAULT NULL,
  `fullmessageformat` tinyint(1) NOT NULL DEFAULT 0,
  `fullmessagehtml` longtext DEFAULT NULL,
  `smallmessage` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `fullmessagetrust` tinyint(2) NOT NULL DEFAULT 0,
  `customdata` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all messages';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_airnotifier_devices`
--

CREATE TABLE `mdlfx_message_airnotifier_devices` (
  `id` bigint(10) NOT NULL,
  `userdeviceid` bigint(10) NOT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store information about the devices registered in Airnotifie';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_contacts`
--

CREATE TABLE `mdlfx_message_contacts` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `contactid` bigint(10) NOT NULL,
  `timecreated` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains lists of contacts between users';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_contact_requests`
--

CREATE TABLE `mdlfx_message_contact_requests` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `requesteduserid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains list of contact requests between users';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_conversations`
--

CREATE TABLE `mdlfx_message_conversations` (
  `id` bigint(10) NOT NULL,
  `type` bigint(10) NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `convhash` varchar(40) DEFAULT NULL,
  `component` varchar(100) DEFAULT NULL,
  `itemtype` varchar(100) DEFAULT NULL,
  `itemid` bigint(10) DEFAULT NULL,
  `contextid` bigint(10) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all message conversations';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_conversation_actions`
--

CREATE TABLE `mdlfx_message_conversation_actions` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `conversationid` bigint(10) NOT NULL,
  `action` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all per-user actions on individual conversations';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_conversation_members`
--

CREATE TABLE `mdlfx_message_conversation_members` (
  `id` bigint(10) NOT NULL,
  `conversationid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all members in a conversations';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_email_messages`
--

CREATE TABLE `mdlfx_message_email_messages` (
  `id` bigint(10) NOT NULL,
  `useridto` bigint(10) NOT NULL,
  `conversationid` bigint(10) NOT NULL,
  `messageid` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeps track of what emails to send in an email digest';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_popup`
--

CREATE TABLE `mdlfx_message_popup` (
  `id` bigint(10) NOT NULL,
  `messageid` bigint(10) NOT NULL,
  `isread` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keep state of notifications for the popup message processor';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_popup_notifications`
--

CREATE TABLE `mdlfx_message_popup_notifications` (
  `id` bigint(10) NOT NULL,
  `notificationid` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of notifications to display in the message output popup';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_processors`
--

CREATE TABLE `mdlfx_message_processors` (
  `id` bigint(10) NOT NULL,
  `name` varchar(166) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of message output plugins';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_providers`
--

CREATE TABLE `mdlfx_message_providers` (
  `id` bigint(10) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `component` varchar(200) NOT NULL DEFAULT '',
  `capability` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores the message providers (modules and core sy';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_read`
--

CREATE TABLE `mdlfx_message_read` (
  `id` bigint(10) NOT NULL,
  `useridfrom` bigint(10) NOT NULL DEFAULT 0,
  `useridto` bigint(10) NOT NULL DEFAULT 0,
  `subject` longtext DEFAULT NULL,
  `fullmessage` longtext DEFAULT NULL,
  `fullmessageformat` smallint(4) DEFAULT 0,
  `fullmessagehtml` longtext DEFAULT NULL,
  `smallmessage` longtext DEFAULT NULL,
  `notification` tinyint(1) DEFAULT 0,
  `contexturl` longtext DEFAULT NULL,
  `contexturlname` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timeread` bigint(10) NOT NULL DEFAULT 0,
  `timeuserfromdeleted` bigint(10) NOT NULL DEFAULT 0,
  `timeusertodeleted` bigint(10) NOT NULL DEFAULT 0,
  `component` varchar(100) DEFAULT NULL,
  `eventtype` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all messages that have been read';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_users_blocked`
--

CREATE TABLE `mdlfx_message_users_blocked` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `blockeduserid` bigint(10) NOT NULL,
  `timecreated` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains lists of blocked users';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_message_user_actions`
--

CREATE TABLE `mdlfx_message_user_actions` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `messageid` bigint(10) NOT NULL,
  `action` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all per-user actions on individual messages';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnetservice_enrol_courses`
--

CREATE TABLE `mdlfx_mnetservice_enrol_courses` (
  `id` bigint(10) NOT NULL,
  `hostid` bigint(10) NOT NULL,
  `remoteid` bigint(10) NOT NULL,
  `categoryid` bigint(10) NOT NULL,
  `categoryname` varchar(255) NOT NULL DEFAULT '',
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `fullname` varchar(254) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `idnumber` varchar(100) NOT NULL DEFAULT '',
  `summary` longtext NOT NULL,
  `summaryformat` smallint(3) DEFAULT 0,
  `startdate` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL,
  `rolename` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches the information fetched via XML-RPC about courses on ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnetservice_enrol_enrolments`
--

CREATE TABLE `mdlfx_mnetservice_enrol_enrolments` (
  `id` bigint(10) NOT NULL,
  `hostid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `remotecourseid` bigint(10) NOT NULL,
  `rolename` varchar(255) NOT NULL DEFAULT '',
  `enroltime` bigint(10) NOT NULL DEFAULT 0,
  `enroltype` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches the information about enrolments of our local users i';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_application`
--

CREATE TABLE `mdlfx_mnet_application` (
  `id` bigint(10) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `display_name` varchar(50) NOT NULL DEFAULT '',
  `xmlrpc_server_url` varchar(255) NOT NULL DEFAULT '',
  `sso_land_url` varchar(255) NOT NULL DEFAULT '',
  `sso_jump_url` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Information about applications on remote hosts';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_host`
--

CREATE TABLE `mdlfx_mnet_host` (
  `id` bigint(10) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `wwwroot` varchar(255) NOT NULL DEFAULT '',
  `ip_address` varchar(45) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `public_key` longtext NOT NULL,
  `public_key_expires` bigint(10) NOT NULL DEFAULT 0,
  `transport` tinyint(2) NOT NULL DEFAULT 0,
  `portno` mediumint(5) NOT NULL DEFAULT 0,
  `last_connect_time` bigint(10) NOT NULL DEFAULT 0,
  `last_log_id` bigint(10) NOT NULL DEFAULT 0,
  `force_theme` tinyint(1) NOT NULL DEFAULT 0,
  `theme` varchar(100) DEFAULT NULL,
  `applicationid` bigint(10) NOT NULL DEFAULT 1,
  `sslverification` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Information about the local and remote hosts for RPC';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_host2service`
--

CREATE TABLE `mdlfx_mnet_host2service` (
  `id` bigint(10) NOT NULL,
  `hostid` bigint(10) NOT NULL DEFAULT 0,
  `serviceid` bigint(10) NOT NULL DEFAULT 0,
  `publish` tinyint(1) NOT NULL DEFAULT 0,
  `subscribe` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Information about the services for a given host';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_log`
--

CREATE TABLE `mdlfx_mnet_log` (
  `id` bigint(10) NOT NULL,
  `hostid` bigint(10) NOT NULL DEFAULT 0,
  `remoteid` bigint(10) NOT NULL DEFAULT 0,
  `time` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `ip` varchar(45) NOT NULL DEFAULT '',
  `course` bigint(10) NOT NULL DEFAULT 0,
  `coursename` varchar(40) NOT NULL DEFAULT '',
  `module` varchar(20) NOT NULL DEFAULT '',
  `cmid` bigint(10) NOT NULL DEFAULT 0,
  `action` varchar(40) NOT NULL DEFAULT '',
  `url` varchar(100) NOT NULL DEFAULT '',
  `info` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store session data from users migrating to other sites';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_remote_rpc`
--

CREATE TABLE `mdlfx_mnet_remote_rpc` (
  `id` bigint(10) NOT NULL,
  `functionname` varchar(40) NOT NULL DEFAULT '',
  `xmlrpcpath` varchar(80) NOT NULL DEFAULT '',
  `plugintype` varchar(20) NOT NULL DEFAULT '',
  `pluginname` varchar(20) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table describes functions that might be called remotely';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_remote_service2rpc`
--

CREATE TABLE `mdlfx_mnet_remote_service2rpc` (
  `id` bigint(10) NOT NULL,
  `serviceid` bigint(10) NOT NULL DEFAULT 0,
  `rpcid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Group functions or methods under a service';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_rpc`
--

CREATE TABLE `mdlfx_mnet_rpc` (
  `id` bigint(10) NOT NULL,
  `functionname` varchar(40) NOT NULL DEFAULT '',
  `xmlrpcpath` varchar(80) NOT NULL DEFAULT '',
  `plugintype` varchar(20) NOT NULL DEFAULT '',
  `pluginname` varchar(20) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `help` longtext NOT NULL,
  `profile` longtext NOT NULL,
  `filename` varchar(100) NOT NULL DEFAULT '',
  `classname` varchar(150) DEFAULT NULL,
  `static` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Functions or methods that we may publish or subscribe to';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_service`
--

CREATE TABLE `mdlfx_mnet_service` (
  `id` bigint(10) NOT NULL,
  `name` varchar(40) NOT NULL DEFAULT '',
  `description` varchar(40) NOT NULL DEFAULT '',
  `apiversion` varchar(10) NOT NULL DEFAULT '',
  `offer` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A service is a group of functions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_service2rpc`
--

CREATE TABLE `mdlfx_mnet_service2rpc` (
  `id` bigint(10) NOT NULL,
  `serviceid` bigint(10) NOT NULL DEFAULT 0,
  `rpcid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Group functions or methods under a service';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_session`
--

CREATE TABLE `mdlfx_mnet_session` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `username` varchar(100) NOT NULL DEFAULT '',
  `token` varchar(40) NOT NULL DEFAULT '',
  `mnethostid` bigint(10) NOT NULL DEFAULT 0,
  `useragent` varchar(40) NOT NULL DEFAULT '',
  `confirm_timeout` bigint(10) NOT NULL DEFAULT 0,
  `session_id` varchar(40) NOT NULL DEFAULT '',
  `expires` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store session data from users migrating to other sites';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_mnet_sso_access_control`
--

CREATE TABLE `mdlfx_mnet_sso_access_control` (
  `id` bigint(10) NOT NULL,
  `username` varchar(100) NOT NULL DEFAULT '',
  `mnet_host_id` bigint(10) NOT NULL DEFAULT 0,
  `accessctrl` varchar(20) NOT NULL DEFAULT 'allow'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users by host permitted (or not) to login from a remote prov';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_modules`
--

CREATE TABLE `mdlfx_modules` (
  `id` bigint(10) NOT NULL,
  `name` varchar(20) NOT NULL DEFAULT '',
  `cron` bigint(10) NOT NULL DEFAULT 0,
  `lastcron` bigint(10) NOT NULL DEFAULT 0,
  `search` varchar(255) NOT NULL DEFAULT '',
  `visible` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='modules available in the site';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_my_pages`
--

CREATE TABLE `mdlfx_my_pages` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) DEFAULT 0,
  `name` varchar(200) NOT NULL DEFAULT '',
  `private` tinyint(1) NOT NULL DEFAULT 1,
  `sortorder` mediumint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Extra user pages for the My Moodle system';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_notifications`
--

CREATE TABLE `mdlfx_notifications` (
  `id` bigint(10) NOT NULL,
  `useridfrom` bigint(10) NOT NULL,
  `useridto` bigint(10) NOT NULL,
  `subject` longtext DEFAULT NULL,
  `fullmessage` longtext DEFAULT NULL,
  `fullmessageformat` tinyint(1) NOT NULL DEFAULT 0,
  `fullmessagehtml` longtext DEFAULT NULL,
  `smallmessage` longtext DEFAULT NULL,
  `component` varchar(100) DEFAULT NULL,
  `eventtype` varchar(100) DEFAULT NULL,
  `contexturl` longtext DEFAULT NULL,
  `contexturlname` longtext DEFAULT NULL,
  `timeread` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `customdata` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all notifications';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_oauth2_access_token`
--

CREATE TABLE `mdlfx_oauth2_access_token` (
  `id` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `issuerid` bigint(10) NOT NULL,
  `token` longtext NOT NULL,
  `expires` bigint(10) NOT NULL,
  `scope` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores access tokens for system accounts in order to be able';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_oauth2_endpoint`
--

CREATE TABLE `mdlfx_oauth2_endpoint` (
  `id` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `url` longtext NOT NULL,
  `issuerid` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Describes the named endpoint for an oauth2 service.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_oauth2_issuer`
--

CREATE TABLE `mdlfx_oauth2_issuer` (
  `id` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `image` longtext NOT NULL,
  `baseurl` longtext NOT NULL,
  `clientid` longtext NOT NULL,
  `clientsecret` longtext NOT NULL,
  `loginscopes` longtext NOT NULL,
  `loginscopesoffline` longtext NOT NULL,
  `loginparams` longtext NOT NULL,
  `loginparamsoffline` longtext NOT NULL,
  `alloweddomains` longtext NOT NULL,
  `scopessupported` longtext DEFAULT NULL,
  `enabled` tinyint(2) NOT NULL DEFAULT 1,
  `showonloginpage` tinyint(2) NOT NULL DEFAULT 1,
  `basicauth` tinyint(2) NOT NULL DEFAULT 0,
  `sortorder` bigint(10) NOT NULL,
  `requireconfirmation` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Details for an oauth 2 connect identity issuer.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_oauth2_system_account`
--

CREATE TABLE `mdlfx_oauth2_system_account` (
  `id` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `issuerid` bigint(10) NOT NULL,
  `refreshtoken` longtext NOT NULL,
  `grantedscopes` longtext NOT NULL,
  `email` longtext DEFAULT NULL,
  `username` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stored details used to get an access token as a system user ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_oauth2_user_field_mapping`
--

CREATE TABLE `mdlfx_oauth2_user_field_mapping` (
  `id` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `issuerid` bigint(10) NOT NULL,
  `externalfield` varchar(64) NOT NULL DEFAULT '',
  `internalfield` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mapping of oauth user fields to moodle fields.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_page`
--

CREATE TABLE `mdlfx_page` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `contentformat` smallint(4) NOT NULL DEFAULT 0,
  `legacyfiles` smallint(4) NOT NULL DEFAULT 0,
  `legacyfileslast` bigint(10) DEFAULT NULL,
  `display` smallint(4) NOT NULL DEFAULT 0,
  `displayoptions` longtext DEFAULT NULL,
  `revision` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is one page and its config data';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_portfolio_instance`
--

CREATE TABLE `mdlfx_portfolio_instance` (
  `id` bigint(10) NOT NULL,
  `plugin` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `visible` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='base table (not including config data) for instances of port';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_portfolio_instance_config`
--

CREATE TABLE `mdlfx_portfolio_instance_config` (
  `id` bigint(10) NOT NULL,
  `instance` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='config for portfolio plugin instances';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_portfolio_instance_user`
--

CREATE TABLE `mdlfx_portfolio_instance_user` (
  `id` bigint(10) NOT NULL,
  `instance` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user data for portfolio instances.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_portfolio_log`
--

CREATE TABLE `mdlfx_portfolio_log` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `time` bigint(10) NOT NULL,
  `portfolio` bigint(10) NOT NULL,
  `caller_class` varchar(150) NOT NULL DEFAULT '',
  `caller_file` varchar(255) NOT NULL DEFAULT '',
  `caller_component` varchar(255) DEFAULT NULL,
  `caller_sha1` varchar(255) NOT NULL DEFAULT '',
  `tempdataid` bigint(10) NOT NULL DEFAULT 0,
  `returnurl` varchar(255) NOT NULL DEFAULT '',
  `continueurl` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='log of portfolio transfers (used to later check for duplicat';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_portfolio_mahara_queue`
--

CREATE TABLE `mdlfx_portfolio_mahara_queue` (
  `id` bigint(10) NOT NULL,
  `transferid` bigint(10) NOT NULL,
  `token` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='maps mahara tokens to transfer ids';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_portfolio_tempdata`
--

CREATE TABLE `mdlfx_portfolio_tempdata` (
  `id` bigint(10) NOT NULL,
  `data` longtext DEFAULT NULL,
  `expirytime` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `instance` bigint(10) DEFAULT 0,
  `queued` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores temporary data for portfolio exports. the id of this ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_post`
--

CREATE TABLE `mdlfx_post` (
  `id` bigint(10) NOT NULL,
  `module` varchar(20) NOT NULL DEFAULT '',
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `moduleid` bigint(10) NOT NULL DEFAULT 0,
  `coursemoduleid` bigint(10) NOT NULL DEFAULT 0,
  `subject` varchar(128) NOT NULL DEFAULT '',
  `summary` longtext DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `uniquehash` varchar(255) NOT NULL DEFAULT '',
  `rating` bigint(10) NOT NULL DEFAULT 0,
  `format` bigint(10) NOT NULL DEFAULT 0,
  `summaryformat` tinyint(2) NOT NULL DEFAULT 0,
  `attachment` varchar(100) DEFAULT NULL,
  `publishstate` varchar(20) NOT NULL DEFAULT 'draft',
  `lastmodified` bigint(10) NOT NULL DEFAULT 0,
  `created` bigint(10) NOT NULL DEFAULT 0,
  `usermodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic post table to hold data blog entries etc in differen';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_profiling`
--

CREATE TABLE `mdlfx_profiling` (
  `id` bigint(10) NOT NULL,
  `runid` varchar(32) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `data` longtext NOT NULL,
  `totalexecutiontime` bigint(10) NOT NULL,
  `totalcputime` bigint(10) NOT NULL,
  `totalcalls` bigint(10) NOT NULL,
  `totalmemory` bigint(10) NOT NULL,
  `runreference` tinyint(2) NOT NULL DEFAULT 0,
  `runcomment` varchar(255) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the results of all the profiling runs';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_ddimageortext`
--

CREATE TABLE `mdlfx_qtype_ddimageortext` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `shuffleanswers` smallint(4) NOT NULL DEFAULT 1,
  `correctfeedback` longtext NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `partiallycorrectfeedback` longtext NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `incorrectfeedback` longtext NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines drag and drop (text or images onto a background imag';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_ddimageortext_drags`
--

CREATE TABLE `mdlfx_qtype_ddimageortext_drags` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `no` bigint(10) NOT NULL DEFAULT 0,
  `draggroup` bigint(10) NOT NULL DEFAULT 0,
  `infinite` smallint(4) NOT NULL DEFAULT 0,
  `label` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Images to drag. Actual file names are not stored here we use';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_ddimageortext_drops`
--

CREATE TABLE `mdlfx_qtype_ddimageortext_drops` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `no` bigint(10) NOT NULL DEFAULT 0,
  `xleft` bigint(10) NOT NULL DEFAULT 0,
  `ytop` bigint(10) NOT NULL DEFAULT 0,
  `choice` bigint(10) NOT NULL DEFAULT 0,
  `label` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drop boxes';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_ddmarker`
--

CREATE TABLE `mdlfx_qtype_ddmarker` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `shuffleanswers` smallint(4) NOT NULL DEFAULT 1,
  `correctfeedback` longtext NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `partiallycorrectfeedback` longtext NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `incorrectfeedback` longtext NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT 0,
  `showmisplaced` smallint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines drag and drop (text or images onto a background imag';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_ddmarker_drags`
--

CREATE TABLE `mdlfx_qtype_ddmarker_drags` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `no` bigint(10) NOT NULL DEFAULT 0,
  `label` longtext NOT NULL,
  `infinite` smallint(4) NOT NULL DEFAULT 0,
  `noofdrags` bigint(10) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Labels for markers to drag.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_ddmarker_drops`
--

CREATE TABLE `mdlfx_qtype_ddmarker_drops` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `no` bigint(10) NOT NULL DEFAULT 0,
  `shape` varchar(255) DEFAULT NULL,
  `coords` longtext NOT NULL,
  `choice` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='drop regions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_essay_options`
--

CREATE TABLE `mdlfx_qtype_essay_options` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL,
  `responseformat` varchar(16) NOT NULL DEFAULT 'editor',
  `responserequired` tinyint(2) NOT NULL DEFAULT 1,
  `responsefieldlines` smallint(4) NOT NULL DEFAULT 15,
  `attachments` smallint(4) NOT NULL DEFAULT 0,
  `attachmentsrequired` smallint(4) NOT NULL DEFAULT 0,
  `graderinfo` longtext DEFAULT NULL,
  `graderinfoformat` smallint(4) NOT NULL DEFAULT 0,
  `responsetemplate` longtext DEFAULT NULL,
  `responsetemplateformat` smallint(4) NOT NULL DEFAULT 0,
  `filetypeslist` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Extra options for essay questions.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_match_options`
--

CREATE TABLE `mdlfx_qtype_match_options` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `shuffleanswers` smallint(4) NOT NULL DEFAULT 1,
  `correctfeedback` longtext NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `partiallycorrectfeedback` longtext NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `incorrectfeedback` longtext NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines the question-type specific options for matching ques';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_match_subquestions`
--

CREATE TABLE `mdlfx_qtype_match_subquestions` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `questiontext` longtext NOT NULL,
  `questiontextformat` tinyint(2) NOT NULL DEFAULT 0,
  `answertext` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The subquestions that make up a matching question';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_multichoice_options`
--

CREATE TABLE `mdlfx_qtype_multichoice_options` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `layout` smallint(4) NOT NULL DEFAULT 0,
  `single` smallint(4) NOT NULL DEFAULT 0,
  `shuffleanswers` smallint(4) NOT NULL DEFAULT 1,
  `correctfeedback` longtext NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `partiallycorrectfeedback` longtext NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `incorrectfeedback` longtext NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `answernumbering` varchar(10) NOT NULL DEFAULT 'abc',
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for multiple choice questions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_randomsamatch_options`
--

CREATE TABLE `mdlfx_qtype_randomsamatch_options` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `choose` bigint(10) NOT NULL DEFAULT 4,
  `subcats` tinyint(2) NOT NULL DEFAULT 1,
  `correctfeedback` longtext NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `partiallycorrectfeedback` longtext NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `incorrectfeedback` longtext NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about a random short-answer matching question';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_qtype_shortanswer_options`
--

CREATE TABLE `mdlfx_qtype_shortanswer_options` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `usecase` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for short answer questions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question`
--

CREATE TABLE `mdlfx_question` (
  `id` bigint(10) NOT NULL,
  `category` bigint(10) NOT NULL DEFAULT 0,
  `parent` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `questiontext` longtext NOT NULL,
  `questiontextformat` tinyint(2) NOT NULL DEFAULT 0,
  `generalfeedback` longtext NOT NULL,
  `generalfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `defaultmark` decimal(12,7) NOT NULL DEFAULT 1.0000000,
  `penalty` decimal(12,7) NOT NULL DEFAULT 0.3333333,
  `qtype` varchar(20) NOT NULL DEFAULT '',
  `length` bigint(10) NOT NULL DEFAULT 1,
  `stamp` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(255) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `createdby` bigint(10) DEFAULT NULL,
  `modifiedby` bigint(10) DEFAULT NULL,
  `idnumber` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The questions themselves';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_answers`
--

CREATE TABLE `mdlfx_question_answers` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `answer` longtext NOT NULL,
  `answerformat` tinyint(2) NOT NULL DEFAULT 0,
  `fraction` decimal(12,7) NOT NULL DEFAULT 0.0000000,
  `feedback` longtext NOT NULL,
  `feedbackformat` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Answers, with a fractional grade (0-1) and feedback';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_attempts`
--

CREATE TABLE `mdlfx_question_attempts` (
  `id` bigint(10) NOT NULL,
  `questionusageid` bigint(10) NOT NULL,
  `slot` bigint(10) NOT NULL,
  `behaviour` varchar(32) NOT NULL DEFAULT '',
  `questionid` bigint(10) NOT NULL,
  `variant` bigint(10) NOT NULL DEFAULT 1,
  `maxmark` decimal(12,7) NOT NULL,
  `minfraction` decimal(12,7) NOT NULL,
  `maxfraction` decimal(12,7) NOT NULL DEFAULT 1.0000000,
  `flagged` tinyint(1) NOT NULL DEFAULT 0,
  `questionsummary` longtext DEFAULT NULL,
  `rightanswer` longtext DEFAULT NULL,
  `responsesummary` longtext DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row here corresponds to an attempt at one question, as ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_attempt_steps`
--

CREATE TABLE `mdlfx_question_attempt_steps` (
  `id` bigint(10) NOT NULL,
  `questionattemptid` bigint(10) NOT NULL,
  `sequencenumber` bigint(10) NOT NULL,
  `state` varchar(13) NOT NULL DEFAULT '',
  `fraction` decimal(12,7) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `userid` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores one step in in a question attempt. As well as the dat';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_attempt_step_data`
--

CREATE TABLE `mdlfx_question_attempt_step_data` (
  `id` bigint(10) NOT NULL,
  `attemptstepid` bigint(10) NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each question_attempt_step has an associative array of the d';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_calculated`
--

CREATE TABLE `mdlfx_question_calculated` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `answer` bigint(10) NOT NULL DEFAULT 0,
  `tolerance` varchar(20) NOT NULL DEFAULT '0.0',
  `tolerancetype` bigint(10) NOT NULL DEFAULT 1,
  `correctanswerlength` bigint(10) NOT NULL DEFAULT 2,
  `correctanswerformat` bigint(10) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for questions of type calculated';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_calculated_options`
--

CREATE TABLE `mdlfx_question_calculated_options` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `synchronize` tinyint(2) NOT NULL DEFAULT 0,
  `single` smallint(4) NOT NULL DEFAULT 0,
  `shuffleanswers` smallint(4) NOT NULL DEFAULT 0,
  `correctfeedback` longtext DEFAULT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `partiallycorrectfeedback` longtext DEFAULT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `incorrectfeedback` longtext DEFAULT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `answernumbering` varchar(10) NOT NULL DEFAULT 'abc',
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for questions of type calculated';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_categories`
--

CREATE TABLE `mdlfx_question_categories` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contextid` bigint(10) NOT NULL DEFAULT 0,
  `info` longtext NOT NULL,
  `infoformat` tinyint(2) NOT NULL DEFAULT 0,
  `stamp` varchar(255) NOT NULL DEFAULT '',
  `parent` bigint(10) NOT NULL DEFAULT 0,
  `sortorder` bigint(10) NOT NULL DEFAULT 999,
  `idnumber` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Categories are for grouping questions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_datasets`
--

CREATE TABLE `mdlfx_question_datasets` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `datasetdefinition` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Many-many relation between questions and dataset definitions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_dataset_definitions`
--

CREATE TABLE `mdlfx_question_dataset_definitions` (
  `id` bigint(10) NOT NULL,
  `category` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` bigint(10) NOT NULL DEFAULT 0,
  `options` varchar(255) NOT NULL DEFAULT '',
  `itemcount` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Organises and stores properties for dataset items';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_dataset_items`
--

CREATE TABLE `mdlfx_question_dataset_items` (
  `id` bigint(10) NOT NULL,
  `definition` bigint(10) NOT NULL DEFAULT 0,
  `itemnumber` bigint(10) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Individual dataset items';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_ddwtos`
--

CREATE TABLE `mdlfx_question_ddwtos` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `shuffleanswers` smallint(4) NOT NULL DEFAULT 1,
  `correctfeedback` longtext NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `partiallycorrectfeedback` longtext NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `incorrectfeedback` longtext NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines drag and drop (words into sentences) questions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_gapselect`
--

CREATE TABLE `mdlfx_question_gapselect` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `shuffleanswers` smallint(4) NOT NULL DEFAULT 1,
  `correctfeedback` longtext NOT NULL,
  `correctfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `partiallycorrectfeedback` longtext NOT NULL,
  `partiallycorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `incorrectfeedback` longtext NOT NULL,
  `incorrectfeedbackformat` tinyint(2) NOT NULL DEFAULT 0,
  `shownumcorrect` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines select missing words questions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_hints`
--

CREATE TABLE `mdlfx_question_hints` (
  `id` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL,
  `hint` longtext NOT NULL,
  `hintformat` smallint(4) NOT NULL DEFAULT 0,
  `shownumcorrect` tinyint(1) DEFAULT NULL,
  `clearwrong` tinyint(1) DEFAULT NULL,
  `options` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the the part of the question definition that gives di';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_multianswer`
--

CREATE TABLE `mdlfx_question_multianswer` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `sequence` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for multianswer questions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_numerical`
--

CREATE TABLE `mdlfx_question_numerical` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `answer` bigint(10) NOT NULL DEFAULT 0,
  `tolerance` varchar(255) NOT NULL DEFAULT '0.0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for numerical questions.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_numerical_options`
--

CREATE TABLE `mdlfx_question_numerical_options` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `showunits` smallint(4) NOT NULL DEFAULT 0,
  `unitsleft` smallint(4) NOT NULL DEFAULT 0,
  `unitgradingtype` smallint(4) NOT NULL DEFAULT 0,
  `unitpenalty` decimal(12,7) NOT NULL DEFAULT 0.1000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for questions of type numerical This table is also u';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_numerical_units`
--

CREATE TABLE `mdlfx_question_numerical_units` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `multiplier` decimal(38,19) NOT NULL DEFAULT 1.0000000000000000000,
  `unit` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Optional unit options for numerical questions. This table is';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_response_analysis`
--

CREATE TABLE `mdlfx_question_response_analysis` (
  `id` bigint(10) NOT NULL,
  `hashcode` varchar(40) NOT NULL DEFAULT '',
  `whichtries` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL,
  `variant` bigint(10) DEFAULT NULL,
  `subqid` varchar(100) NOT NULL DEFAULT '',
  `aid` varchar(100) DEFAULT NULL,
  `response` longtext DEFAULT NULL,
  `credit` decimal(15,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Analysis of student responses given to questions.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_response_count`
--

CREATE TABLE `mdlfx_question_response_count` (
  `id` bigint(10) NOT NULL,
  `analysisid` bigint(10) NOT NULL,
  `try` bigint(10) NOT NULL,
  `rcount` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count for each responses for each try at a question.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_statistics`
--

CREATE TABLE `mdlfx_question_statistics` (
  `id` bigint(10) NOT NULL,
  `hashcode` varchar(40) NOT NULL DEFAULT '',
  `timemodified` bigint(10) NOT NULL,
  `questionid` bigint(10) NOT NULL,
  `slot` bigint(10) DEFAULT NULL,
  `subquestion` smallint(4) NOT NULL,
  `variant` bigint(10) DEFAULT NULL,
  `s` bigint(10) NOT NULL DEFAULT 0,
  `effectiveweight` decimal(15,5) DEFAULT NULL,
  `negcovar` tinyint(2) NOT NULL DEFAULT 0,
  `discriminationindex` decimal(15,5) DEFAULT NULL,
  `discriminativeefficiency` decimal(15,5) DEFAULT NULL,
  `sd` decimal(15,10) DEFAULT NULL,
  `facility` decimal(15,10) DEFAULT NULL,
  `subquestions` longtext DEFAULT NULL,
  `maxmark` decimal(12,7) DEFAULT NULL,
  `positions` longtext DEFAULT NULL,
  `randomguessscore` decimal(12,7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Statistics for individual questions used in an activity.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_truefalse`
--

CREATE TABLE `mdlfx_question_truefalse` (
  `id` bigint(10) NOT NULL,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `trueanswer` bigint(10) NOT NULL DEFAULT 0,
  `falseanswer` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options for True-False questions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_question_usages`
--

CREATE TABLE `mdlfx_question_usages` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `component` varchar(255) NOT NULL DEFAULT '',
  `preferredbehaviour` varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table''s main purpose it to assign a unique id to each a';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz`
--

CREATE TABLE `mdlfx_quiz` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `timeopen` bigint(10) NOT NULL DEFAULT 0,
  `timeclose` bigint(10) NOT NULL DEFAULT 0,
  `timelimit` bigint(10) NOT NULL DEFAULT 0,
  `overduehandling` varchar(16) NOT NULL DEFAULT 'autoabandon',
  `graceperiod` bigint(10) NOT NULL DEFAULT 0,
  `preferredbehaviour` varchar(32) NOT NULL DEFAULT '',
  `canredoquestions` smallint(4) NOT NULL DEFAULT 0,
  `attempts` mediumint(6) NOT NULL DEFAULT 0,
  `attemptonlast` smallint(4) NOT NULL DEFAULT 0,
  `grademethod` smallint(4) NOT NULL DEFAULT 1,
  `decimalpoints` smallint(4) NOT NULL DEFAULT 2,
  `questiondecimalpoints` smallint(4) NOT NULL DEFAULT -1,
  `reviewattempt` mediumint(6) NOT NULL DEFAULT 0,
  `reviewcorrectness` mediumint(6) NOT NULL DEFAULT 0,
  `reviewmarks` mediumint(6) NOT NULL DEFAULT 0,
  `reviewspecificfeedback` mediumint(6) NOT NULL DEFAULT 0,
  `reviewgeneralfeedback` mediumint(6) NOT NULL DEFAULT 0,
  `reviewrightanswer` mediumint(6) NOT NULL DEFAULT 0,
  `reviewoverallfeedback` mediumint(6) NOT NULL DEFAULT 0,
  `questionsperpage` bigint(10) NOT NULL DEFAULT 0,
  `navmethod` varchar(16) NOT NULL DEFAULT 'free',
  `shuffleanswers` smallint(4) NOT NULL DEFAULT 0,
  `sumgrades` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `grade` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `password` varchar(255) NOT NULL DEFAULT '',
  `subnet` varchar(255) NOT NULL DEFAULT '',
  `browsersecurity` varchar(32) NOT NULL DEFAULT '',
  `delay1` bigint(10) NOT NULL DEFAULT 0,
  `delay2` bigint(10) NOT NULL DEFAULT 0,
  `showuserpicture` smallint(4) NOT NULL DEFAULT 0,
  `showblocks` smallint(4) NOT NULL DEFAULT 0,
  `completionattemptsexhausted` tinyint(1) DEFAULT 0,
  `completionpass` tinyint(1) DEFAULT 0,
  `allowofflineattempts` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The settings for each quiz.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_attempts`
--

CREATE TABLE `mdlfx_quiz_attempts` (
  `id` bigint(10) NOT NULL,
  `quiz` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `attempt` mediumint(6) NOT NULL DEFAULT 0,
  `uniqueid` bigint(10) NOT NULL DEFAULT 0,
  `layout` longtext NOT NULL,
  `currentpage` bigint(10) NOT NULL DEFAULT 0,
  `preview` smallint(3) NOT NULL DEFAULT 0,
  `state` varchar(16) NOT NULL DEFAULT 'inprogress',
  `timestart` bigint(10) NOT NULL DEFAULT 0,
  `timefinish` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `timemodifiedoffline` bigint(10) NOT NULL DEFAULT 0,
  `timecheckstate` bigint(10) DEFAULT 0,
  `sumgrades` decimal(10,5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores users attempts at quizzes.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_feedback`
--

CREATE TABLE `mdlfx_quiz_feedback` (
  `id` bigint(10) NOT NULL,
  `quizid` bigint(10) NOT NULL DEFAULT 0,
  `feedbacktext` longtext NOT NULL,
  `feedbacktextformat` tinyint(2) NOT NULL DEFAULT 0,
  `mingrade` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `maxgrade` decimal(10,5) NOT NULL DEFAULT 0.00000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Feedback given to students based on which grade band their o';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_grades`
--

CREATE TABLE `mdlfx_quiz_grades` (
  `id` bigint(10) NOT NULL,
  `quiz` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `grade` decimal(10,5) NOT NULL DEFAULT 0.00000,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the overall grade for each user on the quiz, based on';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_overrides`
--

CREATE TABLE `mdlfx_quiz_overrides` (
  `id` bigint(10) NOT NULL,
  `quiz` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) DEFAULT NULL,
  `userid` bigint(10) DEFAULT NULL,
  `timeopen` bigint(10) DEFAULT NULL,
  `timeclose` bigint(10) DEFAULT NULL,
  `timelimit` bigint(10) DEFAULT NULL,
  `attempts` mediumint(6) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The overrides to quiz settings on a per-user and per-group b';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_overview_regrades`
--

CREATE TABLE `mdlfx_quiz_overview_regrades` (
  `id` bigint(10) NOT NULL,
  `questionusageid` bigint(10) NOT NULL,
  `slot` bigint(10) NOT NULL,
  `newfraction` decimal(12,7) DEFAULT NULL,
  `oldfraction` decimal(12,7) DEFAULT NULL,
  `regraded` smallint(4) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table records which question attempts need regrading an';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_reports`
--

CREATE TABLE `mdlfx_quiz_reports` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `displayorder` bigint(10) NOT NULL,
  `capability` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Lists all the installed quiz reports and their display order';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_sections`
--

CREATE TABLE `mdlfx_quiz_sections` (
  `id` bigint(10) NOT NULL,
  `quizid` bigint(10) NOT NULL,
  `firstslot` bigint(10) NOT NULL,
  `heading` varchar(1333) DEFAULT NULL,
  `shufflequestions` smallint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores sections of a quiz with section name (heading), from ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_slots`
--

CREATE TABLE `mdlfx_quiz_slots` (
  `id` bigint(10) NOT NULL,
  `slot` bigint(10) NOT NULL,
  `quizid` bigint(10) NOT NULL DEFAULT 0,
  `page` bigint(10) NOT NULL,
  `requireprevious` smallint(4) NOT NULL DEFAULT 0,
  `questionid` bigint(10) NOT NULL DEFAULT 0,
  `questioncategoryid` bigint(10) DEFAULT NULL,
  `includingsubcategories` smallint(4) DEFAULT NULL,
  `maxmark` decimal(12,7) NOT NULL DEFAULT 0.0000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the question used in a quiz, with the order, and for ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_slot_tags`
--

CREATE TABLE `mdlfx_quiz_slot_tags` (
  `id` bigint(10) NOT NULL,
  `slotid` bigint(10) DEFAULT NULL,
  `tagid` bigint(10) DEFAULT NULL,
  `tagname` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores data about the tags that a question must have so that';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_quiz_statistics`
--

CREATE TABLE `mdlfx_quiz_statistics` (
  `id` bigint(10) NOT NULL,
  `hashcode` varchar(40) NOT NULL DEFAULT '',
  `whichattempts` smallint(4) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `firstattemptscount` bigint(10) NOT NULL,
  `highestattemptscount` bigint(10) NOT NULL,
  `lastattemptscount` bigint(10) NOT NULL,
  `allattemptscount` bigint(10) NOT NULL,
  `firstattemptsavg` decimal(15,5) DEFAULT NULL,
  `highestattemptsavg` decimal(15,5) DEFAULT NULL,
  `lastattemptsavg` decimal(15,5) DEFAULT NULL,
  `allattemptsavg` decimal(15,5) DEFAULT NULL,
  `median` decimal(15,5) DEFAULT NULL,
  `standarddeviation` decimal(15,5) DEFAULT NULL,
  `skewness` decimal(15,10) DEFAULT NULL,
  `kurtosis` decimal(15,5) DEFAULT NULL,
  `cic` decimal(15,10) DEFAULT NULL,
  `errorratio` decimal(15,10) DEFAULT NULL,
  `standarderror` decimal(15,10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table to cache results from analysis done in statistics repo';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_rating`
--

CREATE TABLE `mdlfx_rating` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `ratingarea` varchar(50) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL,
  `scaleid` bigint(10) NOT NULL,
  `rating` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='moodle ratings';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_registration_hubs`
--

CREATE TABLE `mdlfx_registration_hubs` (
  `id` bigint(10) NOT NULL,
  `token` varchar(255) NOT NULL DEFAULT '',
  `hubname` varchar(255) NOT NULL DEFAULT '',
  `huburl` varchar(255) NOT NULL DEFAULT '',
  `confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `secret` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='hub where the site is registered on with their associated to';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_repository`
--

CREATE TABLE `mdlfx_repository` (
  `id` bigint(10) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `visible` tinyint(1) DEFAULT 1,
  `sortorder` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table contains one entry for every configured external ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_repository_instances`
--

CREATE TABLE `mdlfx_repository_instances` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `typeid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `contextid` bigint(10) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `timecreated` bigint(10) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `readonly` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table contains one entry for every configured external ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_repository_instance_config`
--

CREATE TABLE `mdlfx_repository_instance_config` (
  `id` bigint(10) NOT NULL,
  `instanceid` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The config for intances';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_repository_onedrive_access`
--

CREATE TABLE `mdlfx_repository_onedrive_access` (
  `id` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `usermodified` bigint(10) NOT NULL,
  `permissionid` varchar(255) NOT NULL DEFAULT '',
  `itemid` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of temporary access grants.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_resource`
--

CREATE TABLE `mdlfx_resource` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `tobemigrated` smallint(4) NOT NULL DEFAULT 0,
  `legacyfiles` smallint(4) NOT NULL DEFAULT 0,
  `legacyfileslast` bigint(10) DEFAULT NULL,
  `display` smallint(4) NOT NULL DEFAULT 0,
  `displayoptions` longtext DEFAULT NULL,
  `filterfiles` smallint(4) NOT NULL DEFAULT 0,
  `revision` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is one resource and its config data';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_resource_old`
--

CREATE TABLE `mdlfx_resource_old` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(30) NOT NULL DEFAULT '',
  `reference` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `alltext` longtext NOT NULL,
  `popup` longtext NOT NULL,
  `options` varchar(255) NOT NULL DEFAULT '',
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `oldid` bigint(10) NOT NULL,
  `cmid` bigint(10) DEFAULT NULL,
  `newmodule` varchar(50) DEFAULT NULL,
  `newid` bigint(10) DEFAULT NULL,
  `migrated` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='backup of all old resource instances from 1.9';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role`
--

CREATE TABLE `mdlfx_role` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `shortname` varchar(100) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `archetype` varchar(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='moodle roles';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role_allow_assign`
--

CREATE TABLE `mdlfx_role_allow_assign` (
  `id` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `allowassign` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='this defines what role can assign what role';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role_allow_override`
--

CREATE TABLE `mdlfx_role_allow_override` (
  `id` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `allowoverride` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='this defines what role can override what role';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role_allow_switch`
--

CREATE TABLE `mdlfx_role_allow_switch` (
  `id` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL,
  `allowswitch` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores which which other roles a user is allowed ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role_allow_view`
--

CREATE TABLE `mdlfx_role_allow_view` (
  `id` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL,
  `allowview` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores which which other roles a user is allowed ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role_assignments`
--

CREATE TABLE `mdlfx_role_assignments` (
  `id` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `contextid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `modifierid` bigint(10) NOT NULL DEFAULT 0,
  `component` varchar(100) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL DEFAULT 0,
  `sortorder` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='assigning roles in different context';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role_capabilities`
--

CREATE TABLE `mdlfx_role_capabilities` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL DEFAULT 0,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `capability` varchar(255) NOT NULL DEFAULT '',
  `permission` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `modifierid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='permission has to be signed, overriding a capability for a p';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role_context_levels`
--

CREATE TABLE `mdlfx_role_context_levels` (
  `id` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL,
  `contextlevel` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Lists which roles can be assigned at which context levels. T';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_role_names`
--

CREATE TABLE `mdlfx_role_names` (
  `id` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `contextid` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='role names in native strings';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scale`
--

CREATE TABLE `mdlfx_scale` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `scale` longtext NOT NULL,
  `description` longtext NOT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines grading scales';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scale_history`
--

CREATE TABLE `mdlfx_scale_history` (
  `id` bigint(10) NOT NULL,
  `action` bigint(10) NOT NULL DEFAULT 0,
  `oldid` bigint(10) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `timemodified` bigint(10) DEFAULT NULL,
  `loggeduser` bigint(10) DEFAULT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `scale` longtext NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='History table';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm`
--

CREATE TABLE `mdlfx_scorm` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `scormtype` varchar(50) NOT NULL DEFAULT 'local',
  `reference` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `version` varchar(9) NOT NULL DEFAULT '',
  `maxgrade` double NOT NULL DEFAULT 0,
  `grademethod` tinyint(2) NOT NULL DEFAULT 0,
  `whatgrade` bigint(10) NOT NULL DEFAULT 0,
  `maxattempt` bigint(10) NOT NULL DEFAULT 1,
  `forcecompleted` tinyint(1) NOT NULL DEFAULT 0,
  `forcenewattempt` tinyint(1) NOT NULL DEFAULT 0,
  `lastattemptlock` tinyint(1) NOT NULL DEFAULT 0,
  `masteryoverride` tinyint(1) NOT NULL DEFAULT 1,
  `displayattemptstatus` tinyint(1) NOT NULL DEFAULT 1,
  `displaycoursestructure` tinyint(1) NOT NULL DEFAULT 0,
  `updatefreq` tinyint(1) NOT NULL DEFAULT 0,
  `sha1hash` varchar(40) DEFAULT NULL,
  `md5hash` varchar(32) NOT NULL DEFAULT '',
  `revision` bigint(10) NOT NULL DEFAULT 0,
  `launch` bigint(10) NOT NULL DEFAULT 0,
  `skipview` tinyint(1) NOT NULL DEFAULT 1,
  `hidebrowse` tinyint(1) NOT NULL DEFAULT 0,
  `hidetoc` tinyint(1) NOT NULL DEFAULT 0,
  `nav` tinyint(1) NOT NULL DEFAULT 1,
  `navpositionleft` bigint(10) DEFAULT -100,
  `navpositiontop` bigint(10) DEFAULT -100,
  `auto` tinyint(1) NOT NULL DEFAULT 0,
  `popup` tinyint(1) NOT NULL DEFAULT 0,
  `options` varchar(255) NOT NULL DEFAULT '',
  `width` bigint(10) NOT NULL DEFAULT 100,
  `height` bigint(10) NOT NULL DEFAULT 600,
  `timeopen` bigint(10) NOT NULL DEFAULT 0,
  `timeclose` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `completionstatusrequired` tinyint(1) DEFAULT NULL,
  `completionscorerequired` bigint(10) DEFAULT NULL,
  `completionstatusallscos` tinyint(1) DEFAULT NULL,
  `displayactivityname` smallint(4) NOT NULL DEFAULT 1,
  `autocommit` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each table is one SCORM module and its configuration';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_aicc_session`
--

CREATE TABLE `mdlfx_scorm_aicc_session` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `scormid` bigint(10) NOT NULL DEFAULT 0,
  `hacpsession` varchar(255) NOT NULL DEFAULT '',
  `scoid` bigint(10) DEFAULT 0,
  `scormmode` varchar(50) DEFAULT NULL,
  `scormstatus` varchar(255) DEFAULT NULL,
  `attempt` bigint(10) DEFAULT NULL,
  `lessonstatus` varchar(255) DEFAULT NULL,
  `sessiontime` varchar(255) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used by AICC HACP to store session information';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_scoes`
--

CREATE TABLE `mdlfx_scorm_scoes` (
  `id` bigint(10) NOT NULL,
  `scorm` bigint(10) NOT NULL DEFAULT 0,
  `manifest` varchar(255) NOT NULL DEFAULT '',
  `organization` varchar(255) NOT NULL DEFAULT '',
  `parent` varchar(255) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `launch` longtext NOT NULL,
  `scormtype` varchar(5) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `sortorder` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each SCO part of the SCORM module';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_scoes_data`
--

CREATE TABLE `mdlfx_scorm_scoes_data` (
  `id` bigint(10) NOT NULL,
  `scoid` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains variable data get from packages';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_scoes_track`
--

CREATE TABLE `mdlfx_scorm_scoes_track` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `scormid` bigint(10) NOT NULL DEFAULT 0,
  `scoid` bigint(10) NOT NULL DEFAULT 0,
  `attempt` bigint(10) NOT NULL DEFAULT 1,
  `element` varchar(255) NOT NULL DEFAULT '',
  `value` longtext NOT NULL,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='to track SCOes';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_seq_mapinfo`
--

CREATE TABLE `mdlfx_scorm_seq_mapinfo` (
  `id` bigint(10) NOT NULL,
  `scoid` bigint(10) NOT NULL DEFAULT 0,
  `objectiveid` bigint(10) NOT NULL DEFAULT 0,
  `targetobjectiveid` bigint(10) NOT NULL DEFAULT 0,
  `readsatisfiedstatus` tinyint(1) NOT NULL DEFAULT 1,
  `readnormalizedmeasure` tinyint(1) NOT NULL DEFAULT 1,
  `writesatisfiedstatus` tinyint(1) NOT NULL DEFAULT 0,
  `writenormalizedmeasure` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 objective mapinfo description';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_seq_objective`
--

CREATE TABLE `mdlfx_scorm_seq_objective` (
  `id` bigint(10) NOT NULL,
  `scoid` bigint(10) NOT NULL DEFAULT 0,
  `primaryobj` tinyint(1) NOT NULL DEFAULT 0,
  `objectiveid` varchar(255) NOT NULL DEFAULT '',
  `satisfiedbymeasure` tinyint(1) NOT NULL DEFAULT 1,
  `minnormalizedmeasure` float(11,4) NOT NULL DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 objective description';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_seq_rolluprule`
--

CREATE TABLE `mdlfx_scorm_seq_rolluprule` (
  `id` bigint(10) NOT NULL,
  `scoid` bigint(10) NOT NULL DEFAULT 0,
  `childactivityset` varchar(15) NOT NULL DEFAULT '',
  `minimumcount` bigint(10) NOT NULL DEFAULT 0,
  `minimumpercent` float(11,4) NOT NULL DEFAULT 0.0000,
  `conditioncombination` varchar(3) NOT NULL DEFAULT 'all',
  `action` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 sequencing rule';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_seq_rolluprulecond`
--

CREATE TABLE `mdlfx_scorm_seq_rolluprulecond` (
  `id` bigint(10) NOT NULL,
  `scoid` bigint(10) NOT NULL DEFAULT 0,
  `rollupruleid` bigint(10) NOT NULL DEFAULT 0,
  `operator` varchar(5) NOT NULL DEFAULT 'noOp',
  `cond` varchar(25) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 sequencing rule';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_seq_rulecond`
--

CREATE TABLE `mdlfx_scorm_seq_rulecond` (
  `id` bigint(10) NOT NULL,
  `scoid` bigint(10) NOT NULL DEFAULT 0,
  `ruleconditionsid` bigint(10) NOT NULL DEFAULT 0,
  `refrencedobjective` varchar(255) NOT NULL DEFAULT '',
  `measurethreshold` float(11,4) NOT NULL DEFAULT 0.0000,
  `operator` varchar(5) NOT NULL DEFAULT 'noOp',
  `cond` varchar(30) NOT NULL DEFAULT 'always'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 rule condition';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_scorm_seq_ruleconds`
--

CREATE TABLE `mdlfx_scorm_seq_ruleconds` (
  `id` bigint(10) NOT NULL,
  `scoid` bigint(10) NOT NULL DEFAULT 0,
  `conditioncombination` varchar(3) NOT NULL DEFAULT 'all',
  `ruletype` tinyint(2) NOT NULL DEFAULT 0,
  `action` varchar(25) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SCORM2004 rule conditions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_search_index_requests`
--

CREATE TABLE `mdlfx_search_index_requests` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `searcharea` varchar(255) NOT NULL DEFAULT '',
  `timerequested` bigint(10) NOT NULL,
  `partialarea` varchar(255) NOT NULL DEFAULT '',
  `partialtime` bigint(10) NOT NULL,
  `indexpriority` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Records requests for (re)indexing of specific contexts. Entr';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_search_simpledb_index`
--

CREATE TABLE `mdlfx_search_simpledb_index` (
  `id` bigint(10) NOT NULL,
  `docid` varchar(255) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL,
  `title` longtext DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `contextid` bigint(10) NOT NULL,
  `areaid` varchar(255) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `owneruserid` bigint(10) DEFAULT NULL,
  `modified` bigint(10) NOT NULL,
  `userid` bigint(10) DEFAULT NULL,
  `description1` longtext DEFAULT NULL,
  `description2` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='search_simpledb table containing the index data.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_sessions`
--

CREATE TABLE `mdlfx_sessions` (
  `id` bigint(10) NOT NULL,
  `state` bigint(10) NOT NULL DEFAULT 0,
  `sid` varchar(128) NOT NULL DEFAULT '',
  `userid` bigint(10) NOT NULL,
  `sessdata` longtext DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `firstip` varchar(45) DEFAULT NULL,
  `lastip` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database based session storage - now recommended';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_stats_daily`
--

CREATE TABLE `mdlfx_stats_daily` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 0,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `stattype` varchar(20) NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) NOT NULL DEFAULT 0,
  `stat2` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='to accumulate daily stats';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_stats_monthly`
--

CREATE TABLE `mdlfx_stats_monthly` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 0,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `stattype` varchar(20) NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) NOT NULL DEFAULT 0,
  `stat2` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate monthly stats';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_stats_user_daily`
--

CREATE TABLE `mdlfx_stats_user_daily` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 0,
  `statsreads` bigint(10) NOT NULL DEFAULT 0,
  `statswrites` bigint(10) NOT NULL DEFAULT 0,
  `stattype` varchar(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate daily stats per course/user';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_stats_user_monthly`
--

CREATE TABLE `mdlfx_stats_user_monthly` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 0,
  `statsreads` bigint(10) NOT NULL DEFAULT 0,
  `statswrites` bigint(10) NOT NULL DEFAULT 0,
  `stattype` varchar(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate monthly stats per course/user';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_stats_user_weekly`
--

CREATE TABLE `mdlfx_stats_user_weekly` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 0,
  `statsreads` bigint(10) NOT NULL DEFAULT 0,
  `statswrites` bigint(10) NOT NULL DEFAULT 0,
  `stattype` varchar(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate weekly stats per course/user';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_stats_weekly`
--

CREATE TABLE `mdlfx_stats_weekly` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 0,
  `roleid` bigint(10) NOT NULL DEFAULT 0,
  `stattype` varchar(20) NOT NULL DEFAULT 'activity',
  `stat1` bigint(10) NOT NULL DEFAULT 0,
  `stat2` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To accumulate weekly stats';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_survey`
--

CREATE TABLE `mdlfx_survey` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `template` bigint(10) NOT NULL DEFAULT 0,
  `days` mediumint(6) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext NOT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `questions` varchar(255) NOT NULL DEFAULT '',
  `completionsubmit` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is one SURVEY module with its configuration';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_survey_analysis`
--

CREATE TABLE `mdlfx_survey_analysis` (
  `id` bigint(10) NOT NULL,
  `survey` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `notes` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='text about each survey submission';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_survey_answers`
--

CREATE TABLE `mdlfx_survey_answers` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `survey` bigint(10) NOT NULL DEFAULT 0,
  `question` bigint(10) NOT NULL DEFAULT 0,
  `time` bigint(10) NOT NULL DEFAULT 0,
  `answer1` longtext NOT NULL,
  `answer2` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='the answers to each questions filled by the users';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_survey_questions`
--

CREATE TABLE `mdlfx_survey_questions` (
  `id` bigint(10) NOT NULL,
  `text` varchar(255) NOT NULL DEFAULT '',
  `shorttext` varchar(30) NOT NULL DEFAULT '',
  `multi` varchar(100) NOT NULL DEFAULT '',
  `intro` varchar(50) NOT NULL DEFAULT '',
  `type` smallint(3) NOT NULL DEFAULT 0,
  `options` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='the questions conforming one survey';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tag`
--

CREATE TABLE `mdlfx_tag` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `tagcollid` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `rawname` varchar(255) NOT NULL DEFAULT '',
  `isstandard` tinyint(1) NOT NULL DEFAULT 0,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0,
  `flag` smallint(4) DEFAULT 0,
  `timemodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag table - this generic table will replace the old "tags" t';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tag_area`
--

CREATE TABLE `mdlfx_tag_area` (
  `id` bigint(10) NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `itemtype` varchar(100) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `tagcollid` bigint(10) NOT NULL,
  `callback` varchar(100) DEFAULT NULL,
  `callbackfile` varchar(100) DEFAULT NULL,
  `showstandard` tinyint(1) NOT NULL DEFAULT 0,
  `multiplecontexts` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines various tag areas, one area is identified by compone';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tag_coll`
--

CREATE TABLE `mdlfx_tag_coll` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `isdefault` tinyint(2) NOT NULL DEFAULT 0,
  `component` varchar(100) DEFAULT NULL,
  `sortorder` mediumint(5) NOT NULL DEFAULT 0,
  `searchable` tinyint(2) NOT NULL DEFAULT 1,
  `customurl` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines different set of tags';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tag_correlation`
--

CREATE TABLE `mdlfx_tag_correlation` (
  `id` bigint(10) NOT NULL,
  `tagid` bigint(10) NOT NULL,
  `correlatedtags` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The rationale for the ''tag_correlation'' table is performance';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tag_instance`
--

CREATE TABLE `mdlfx_tag_instance` (
  `id` bigint(10) NOT NULL,
  `tagid` bigint(10) NOT NULL,
  `component` varchar(100) NOT NULL DEFAULT '',
  `itemtype` varchar(100) NOT NULL DEFAULT '',
  `itemid` bigint(10) NOT NULL,
  `contextid` bigint(10) DEFAULT NULL,
  `tiuserid` bigint(10) NOT NULL DEFAULT 0,
  `ordering` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tag_instance table holds the information of associations bet';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_task_adhoc`
--

CREATE TABLE `mdlfx_task_adhoc` (
  `id` bigint(10) NOT NULL,
  `component` varchar(255) NOT NULL DEFAULT '',
  `classname` varchar(255) NOT NULL DEFAULT '',
  `nextruntime` bigint(10) NOT NULL,
  `faildelay` bigint(10) DEFAULT NULL,
  `customdata` longtext DEFAULT NULL,
  `userid` bigint(10) DEFAULT NULL,
  `blocking` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of adhoc tasks waiting to run.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_task_log`
--

CREATE TABLE `mdlfx_task_log` (
  `id` bigint(10) NOT NULL,
  `type` smallint(4) NOT NULL,
  `component` varchar(255) NOT NULL DEFAULT '',
  `classname` varchar(255) NOT NULL DEFAULT '',
  `userid` bigint(10) NOT NULL,
  `timestart` decimal(20,10) NOT NULL,
  `timeend` decimal(20,10) NOT NULL,
  `dbreads` bigint(10) NOT NULL,
  `dbwrites` bigint(10) NOT NULL,
  `result` tinyint(2) NOT NULL,
  `output` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The log table for all tasks';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_task_scheduled`
--

CREATE TABLE `mdlfx_task_scheduled` (
  `id` bigint(10) NOT NULL,
  `component` varchar(255) NOT NULL DEFAULT '',
  `classname` varchar(255) NOT NULL DEFAULT '',
  `lastruntime` bigint(10) DEFAULT NULL,
  `nextruntime` bigint(10) DEFAULT NULL,
  `blocking` tinyint(2) NOT NULL DEFAULT 0,
  `minute` varchar(25) NOT NULL DEFAULT '',
  `hour` varchar(25) NOT NULL DEFAULT '',
  `day` varchar(25) NOT NULL DEFAULT '',
  `month` varchar(25) NOT NULL DEFAULT '',
  `dayofweek` varchar(25) NOT NULL DEFAULT '',
  `faildelay` bigint(10) DEFAULT NULL,
  `customised` tinyint(2) NOT NULL DEFAULT 0,
  `disabled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of scheduled tasks to be run by cron.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_cohortroles`
--

CREATE TABLE `mdlfx_tool_cohortroles` (
  `id` bigint(10) NOT NULL,
  `cohortid` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `usermodified` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mapping of users to cohort role assignments.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_customlang`
--

CREATE TABLE `mdlfx_tool_customlang` (
  `id` bigint(10) NOT NULL,
  `lang` varchar(20) NOT NULL DEFAULT '',
  `componentid` bigint(10) NOT NULL,
  `stringid` varchar(255) NOT NULL DEFAULT '',
  `original` longtext NOT NULL,
  `master` longtext DEFAULT NULL,
  `local` longtext DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL,
  `timecustomized` bigint(10) DEFAULT NULL,
  `outdated` smallint(3) DEFAULT 0,
  `modified` smallint(3) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the working checkout of all strings and their custo';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_customlang_components`
--

CREATE TABLE `mdlfx_tool_customlang_components` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the list of all installed plugins that provide thei';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_dataprivacy_category`
--

CREATE TABLE `mdlfx_tool_dataprivacy_category` (
  `id` bigint(10) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(1) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data categories';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_dataprivacy_ctxexpired`
--

CREATE TABLE `mdlfx_tool_dataprivacy_ctxexpired` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `unexpiredroles` longtext DEFAULT NULL,
  `expiredroles` longtext DEFAULT NULL,
  `defaultexpired` tinyint(1) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Default comment for the table, please edit me';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_dataprivacy_ctxinstance`
--

CREATE TABLE `mdlfx_tool_dataprivacy_ctxinstance` (
  `id` bigint(10) NOT NULL,
  `contextid` bigint(10) NOT NULL,
  `purposeid` bigint(10) DEFAULT NULL,
  `categoryid` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Default comment for the table, please edit me';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_dataprivacy_ctxlevel`
--

CREATE TABLE `mdlfx_tool_dataprivacy_ctxlevel` (
  `id` bigint(10) NOT NULL,
  `contextlevel` smallint(3) NOT NULL,
  `purposeid` bigint(10) DEFAULT NULL,
  `categoryid` bigint(10) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Default comment for the table, please edit me';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_dataprivacy_purpose`
--

CREATE TABLE `mdlfx_tool_dataprivacy_purpose` (
  `id` bigint(10) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(1) DEFAULT NULL,
  `lawfulbases` longtext NOT NULL,
  `sensitivedatareasons` longtext DEFAULT NULL,
  `retentionperiod` varchar(255) NOT NULL DEFAULT '',
  `protected` tinyint(1) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data purposes';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_dataprivacy_purposerole`
--

CREATE TABLE `mdlfx_tool_dataprivacy_purposerole` (
  `id` bigint(10) NOT NULL,
  `purposeid` bigint(10) NOT NULL,
  `roleid` bigint(10) NOT NULL,
  `lawfulbases` longtext DEFAULT NULL,
  `sensitivedatareasons` longtext DEFAULT NULL,
  `retentionperiod` varchar(255) NOT NULL DEFAULT '',
  `protected` tinyint(1) DEFAULT NULL,
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data purpose overrides for a specific role';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_dataprivacy_request`
--

CREATE TABLE `mdlfx_tool_dataprivacy_request` (
  `id` bigint(10) NOT NULL,
  `type` bigint(10) NOT NULL DEFAULT 0,
  `comments` longtext DEFAULT NULL,
  `commentsformat` tinyint(2) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `requestedby` bigint(10) NOT NULL DEFAULT 0,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `dpo` bigint(10) DEFAULT 0,
  `dpocomment` longtext DEFAULT NULL,
  `dpocommentformat` tinyint(2) NOT NULL DEFAULT 0,
  `usermodified` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `creationmethod` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for data requests';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_monitor_events`
--

CREATE TABLE `mdlfx_tool_monitor_events` (
  `id` bigint(10) NOT NULL,
  `eventname` varchar(254) NOT NULL DEFAULT '',
  `contextid` bigint(10) NOT NULL,
  `contextlevel` bigint(10) NOT NULL,
  `contextinstanceid` bigint(10) NOT NULL,
  `link` varchar(254) NOT NULL DEFAULT '',
  `courseid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A table that keeps a log of events related to subscriptions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_monitor_history`
--

CREATE TABLE `mdlfx_tool_monitor_history` (
  `id` bigint(10) NOT NULL,
  `sid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timesent` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store history of message notifications sent';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_monitor_rules`
--

CREATE TABLE `mdlfx_tool_monitor_rules` (
  `id` bigint(10) NOT NULL,
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(1) NOT NULL,
  `name` varchar(254) NOT NULL DEFAULT '',
  `userid` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `plugin` varchar(254) NOT NULL DEFAULT '',
  `eventname` varchar(254) NOT NULL DEFAULT '',
  `template` longtext NOT NULL,
  `templateformat` tinyint(1) NOT NULL,
  `frequency` smallint(4) NOT NULL,
  `timewindow` mediumint(5) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store rules';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_monitor_subscriptions`
--

CREATE TABLE `mdlfx_tool_monitor_subscriptions` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `ruleid` bigint(10) NOT NULL,
  `cmid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `lastnotificationsent` bigint(10) NOT NULL DEFAULT 0,
  `inactivedate` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store user subscriptions to various rules';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_policy`
--

CREATE TABLE `mdlfx_tool_policy` (
  `id` bigint(10) NOT NULL,
  `sortorder` mediumint(5) NOT NULL DEFAULT 999,
  `currentversionid` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the list of policy documents defined on the site.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_policy_acceptances`
--

CREATE TABLE `mdlfx_tool_policy_acceptances` (
  `id` bigint(10) NOT NULL,
  `policyversionid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `lang` varchar(30) NOT NULL DEFAULT '',
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `note` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tracks users accepting the policy versions';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_policy_versions`
--

CREATE TABLE `mdlfx_tool_policy_versions` (
  `id` bigint(10) NOT NULL,
  `name` varchar(1333) NOT NULL DEFAULT '',
  `type` smallint(3) NOT NULL DEFAULT 0,
  `audience` smallint(3) NOT NULL DEFAULT 0,
  `archived` smallint(3) NOT NULL DEFAULT 0,
  `usermodified` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `policyid` bigint(10) NOT NULL,
  `agreementstyle` smallint(3) NOT NULL DEFAULT 0,
  `optional` smallint(3) NOT NULL DEFAULT 0,
  `revision` varchar(1333) NOT NULL DEFAULT '',
  `summary` longtext NOT NULL,
  `summaryformat` smallint(3) NOT NULL,
  `content` longtext NOT NULL,
  `contentformat` smallint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds versions of the policy documents';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_recyclebin_category`
--

CREATE TABLE `mdlfx_tool_recyclebin_category` (
  `id` bigint(10) NOT NULL,
  `categoryid` bigint(10) NOT NULL,
  `shortname` varchar(255) NOT NULL DEFAULT '',
  `fullname` varchar(255) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of items in the category recycle bin';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_recyclebin_course`
--

CREATE TABLE `mdlfx_tool_recyclebin_course` (
  `id` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `section` bigint(10) NOT NULL,
  `module` bigint(10) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of items in the course recycle bin';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_usertours_steps`
--

CREATE TABLE `mdlfx_tool_usertours_steps` (
  `id` bigint(10) NOT NULL,
  `tourid` bigint(10) NOT NULL,
  `title` longtext DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `targettype` tinyint(2) NOT NULL,
  `targetvalue` longtext NOT NULL,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `configdata` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Steps in an tour';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_tool_usertours_tours`
--

CREATE TABLE `mdlfx_tool_usertours_tours` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `pathmatch` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `configdata` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of tours';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_upgrade_log`
--

CREATE TABLE `mdlfx_upgrade_log` (
  `id` bigint(10) NOT NULL,
  `type` bigint(10) NOT NULL,
  `plugin` varchar(100) DEFAULT NULL,
  `version` varchar(100) DEFAULT NULL,
  `targetversion` varchar(100) DEFAULT NULL,
  `info` varchar(255) NOT NULL DEFAULT '',
  `details` longtext DEFAULT NULL,
  `backtrace` longtext DEFAULT NULL,
  `userid` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Upgrade logging';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_url`
--

CREATE TABLE `mdlfx_url` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `externalurl` longtext NOT NULL,
  `display` smallint(4) NOT NULL DEFAULT 0,
  `displayoptions` longtext DEFAULT NULL,
  `parameters` longtext DEFAULT NULL,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='each record is one url resource';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user`
--

CREATE TABLE `mdlfx_user` (
  `id` bigint(10) NOT NULL,
  `auth` varchar(20) NOT NULL DEFAULT 'manual',
  `confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `policyagreed` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `mnethostid` bigint(10) NOT NULL DEFAULT 0,
  `username` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `idnumber` varchar(255) NOT NULL DEFAULT '',
  `firstname` varchar(100) NOT NULL DEFAULT '',
  `lastname` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `emailstop` tinyint(1) NOT NULL DEFAULT 0,
  `icq` varchar(15) NOT NULL DEFAULT '',
  `skype` varchar(50) NOT NULL DEFAULT '',
  `yahoo` varchar(50) NOT NULL DEFAULT '',
  `aim` varchar(50) NOT NULL DEFAULT '',
  `msn` varchar(50) NOT NULL DEFAULT '',
  `phone1` varchar(20) NOT NULL DEFAULT '',
  `phone2` varchar(20) NOT NULL DEFAULT '',
  `institution` varchar(255) NOT NULL DEFAULT '',
  `department` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '',
  `city` varchar(120) NOT NULL DEFAULT '',
  `country` varchar(2) NOT NULL DEFAULT '',
  `lang` varchar(30) NOT NULL DEFAULT 'en',
  `calendartype` varchar(30) NOT NULL DEFAULT 'gregorian',
  `theme` varchar(50) NOT NULL DEFAULT '',
  `timezone` varchar(100) NOT NULL DEFAULT '99',
  `firstaccess` bigint(10) NOT NULL DEFAULT 0,
  `lastaccess` bigint(10) NOT NULL DEFAULT 0,
  `lastlogin` bigint(10) NOT NULL DEFAULT 0,
  `currentlogin` bigint(10) NOT NULL DEFAULT 0,
  `lastip` varchar(45) NOT NULL DEFAULT '',
  `secret` varchar(15) NOT NULL DEFAULT '',
  `picture` bigint(10) NOT NULL DEFAULT 0,
  `url` varchar(255) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 1,
  `mailformat` tinyint(1) NOT NULL DEFAULT 1,
  `maildigest` tinyint(1) NOT NULL DEFAULT 0,
  `maildisplay` tinyint(2) NOT NULL DEFAULT 2,
  `autosubscribe` tinyint(1) NOT NULL DEFAULT 1,
  `trackforums` tinyint(1) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `trustbitmask` bigint(10) NOT NULL DEFAULT 0,
  `imagealt` varchar(255) DEFAULT NULL,
  `lastnamephonetic` varchar(255) DEFAULT NULL,
  `firstnamephonetic` varchar(255) DEFAULT NULL,
  `middlename` varchar(255) DEFAULT NULL,
  `alternatename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='One record for each person';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_devices`
--

CREATE TABLE `mdlfx_user_devices` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `appid` varchar(128) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `model` varchar(32) NOT NULL DEFAULT '',
  `platform` varchar(32) NOT NULL DEFAULT '',
  `version` varchar(32) NOT NULL DEFAULT '',
  `pushid` varchar(255) NOT NULL DEFAULT '',
  `uuid` varchar(255) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores user''s mobile devices information in order';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_enrolments`
--

CREATE TABLE `mdlfx_user_enrolments` (
  `id` bigint(10) NOT NULL,
  `status` bigint(10) NOT NULL DEFAULT 0,
  `enrolid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timestart` bigint(10) NOT NULL DEFAULT 0,
  `timeend` bigint(10) NOT NULL DEFAULT 2147483647,
  `modifierid` bigint(10) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users participating in courses (aka enrolled users) - everyb';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_info_category`
--

CREATE TABLE `mdlfx_user_info_category` (
  `id` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sortorder` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customisable fields categories';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_info_data`
--

CREATE TABLE `mdlfx_user_info_data` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `fieldid` bigint(10) NOT NULL DEFAULT 0,
  `data` longtext NOT NULL,
  `dataformat` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data for the customisable user fields';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_info_field`
--

CREATE TABLE `mdlfx_user_info_field` (
  `id` bigint(10) NOT NULL,
  `shortname` varchar(255) NOT NULL DEFAULT 'shortname',
  `name` longtext NOT NULL,
  `datatype` varchar(255) NOT NULL DEFAULT '',
  `description` longtext DEFAULT NULL,
  `descriptionformat` tinyint(2) NOT NULL DEFAULT 0,
  `categoryid` bigint(10) NOT NULL DEFAULT 0,
  `sortorder` bigint(10) NOT NULL DEFAULT 0,
  `required` tinyint(2) NOT NULL DEFAULT 0,
  `locked` tinyint(2) NOT NULL DEFAULT 0,
  `visible` smallint(4) NOT NULL DEFAULT 0,
  `forceunique` tinyint(2) NOT NULL DEFAULT 0,
  `signup` tinyint(2) NOT NULL DEFAULT 0,
  `defaultdata` longtext DEFAULT NULL,
  `defaultdataformat` tinyint(2) NOT NULL DEFAULT 0,
  `param1` longtext DEFAULT NULL,
  `param2` longtext DEFAULT NULL,
  `param3` longtext DEFAULT NULL,
  `param4` longtext DEFAULT NULL,
  `param5` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customisable user profile fields';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_lastaccess`
--

CREATE TABLE `mdlfx_user_lastaccess` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `courseid` bigint(10) NOT NULL DEFAULT 0,
  `timeaccess` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='To keep track of course page access times, used in online pa';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_password_history`
--

CREATE TABLE `mdlfx_user_password_history` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `hash` varchar(255) NOT NULL DEFAULT '',
  `timecreated` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A rotating log of hashes of previously used passwords for ea';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_password_resets`
--

CREATE TABLE `mdlfx_user_password_resets` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `timerequested` bigint(10) NOT NULL,
  `timererequested` bigint(10) NOT NULL DEFAULT 0,
  `token` varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table tracking password reset confirmation tokens';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_preferences`
--

CREATE TABLE `mdlfx_user_preferences` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(1333) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Allows modules to store arbitrary user preferences';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_user_private_key`
--

CREATE TABLE `mdlfx_user_private_key` (
  `id` bigint(10) NOT NULL,
  `script` varchar(128) NOT NULL DEFAULT '',
  `value` varchar(128) NOT NULL DEFAULT '',
  `userid` bigint(10) NOT NULL,
  `instance` bigint(10) DEFAULT NULL,
  `iprestriction` varchar(255) DEFAULT NULL,
  `validuntil` bigint(10) DEFAULT NULL,
  `timecreated` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='access keys used in cookieless scripts - rss, etc.';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_wiki`
--

CREATE TABLE `mdlfx_wiki` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT 'Wiki',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(4) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `firstpagetitle` varchar(255) NOT NULL DEFAULT 'First Page',
  `wikimode` varchar(20) NOT NULL DEFAULT 'collaborative',
  `defaultformat` varchar(20) NOT NULL DEFAULT 'creole',
  `forceformat` tinyint(1) NOT NULL DEFAULT 1,
  `editbegin` bigint(10) NOT NULL DEFAULT 0,
  `editend` bigint(10) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores Wiki activity configuration';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_wiki_links`
--

CREATE TABLE `mdlfx_wiki_links` (
  `id` bigint(10) NOT NULL,
  `subwikiid` bigint(10) NOT NULL DEFAULT 0,
  `frompageid` bigint(10) NOT NULL DEFAULT 0,
  `topageid` bigint(10) NOT NULL DEFAULT 0,
  `tomissingpage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Page wiki links';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_wiki_locks`
--

CREATE TABLE `mdlfx_wiki_locks` (
  `id` bigint(10) NOT NULL,
  `pageid` bigint(10) NOT NULL DEFAULT 0,
  `sectionname` varchar(255) DEFAULT NULL,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `lockedat` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Manages page locks';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_wiki_pages`
--

CREATE TABLE `mdlfx_wiki_pages` (
  `id` bigint(10) NOT NULL,
  `subwikiid` bigint(10) NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL DEFAULT 'title',
  `cachedcontent` longtext NOT NULL,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL DEFAULT 0,
  `timerendered` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0,
  `pageviews` bigint(10) NOT NULL DEFAULT 0,
  `readonly` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores wiki pages';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_wiki_subwikis`
--

CREATE TABLE `mdlfx_wiki_subwikis` (
  `id` bigint(10) NOT NULL,
  `wikiid` bigint(10) NOT NULL DEFAULT 0,
  `groupid` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores subwiki instances';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_wiki_synonyms`
--

CREATE TABLE `mdlfx_wiki_synonyms` (
  `id` bigint(10) NOT NULL,
  `subwikiid` bigint(10) NOT NULL DEFAULT 0,
  `pageid` bigint(10) NOT NULL DEFAULT 0,
  `pagesynonym` varchar(255) NOT NULL DEFAULT 'Pagesynonym'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores wiki pages synonyms';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_wiki_versions`
--

CREATE TABLE `mdlfx_wiki_versions` (
  `id` bigint(10) NOT NULL,
  `pageid` bigint(10) NOT NULL DEFAULT 0,
  `content` longtext NOT NULL,
  `contentformat` varchar(20) NOT NULL DEFAULT 'creole',
  `version` mediumint(5) NOT NULL DEFAULT 0,
  `timecreated` bigint(10) NOT NULL DEFAULT 0,
  `userid` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores wiki page history';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshop`
--

CREATE TABLE `mdlfx_workshop` (
  `id` bigint(10) NOT NULL,
  `course` bigint(10) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` longtext DEFAULT NULL,
  `introformat` smallint(3) NOT NULL DEFAULT 0,
  `instructauthors` longtext DEFAULT NULL,
  `instructauthorsformat` smallint(3) NOT NULL DEFAULT 0,
  `instructreviewers` longtext DEFAULT NULL,
  `instructreviewersformat` smallint(3) NOT NULL DEFAULT 0,
  `timemodified` bigint(10) NOT NULL,
  `phase` smallint(3) DEFAULT 0,
  `useexamples` tinyint(2) DEFAULT 0,
  `usepeerassessment` tinyint(2) DEFAULT 0,
  `useselfassessment` tinyint(2) DEFAULT 0,
  `grade` decimal(10,5) DEFAULT 80.00000,
  `gradinggrade` decimal(10,5) DEFAULT 20.00000,
  `strategy` varchar(30) NOT NULL DEFAULT '',
  `evaluation` varchar(30) NOT NULL DEFAULT '',
  `gradedecimals` smallint(3) DEFAULT 0,
  `submissiontypetext` tinyint(1) NOT NULL DEFAULT 1,
  `submissiontypefile` tinyint(1) NOT NULL DEFAULT 1,
  `nattachments` smallint(3) DEFAULT 1,
  `submissionfiletypes` varchar(255) DEFAULT NULL,
  `latesubmissions` tinyint(2) DEFAULT 0,
  `maxbytes` bigint(10) DEFAULT 100000,
  `examplesmode` smallint(3) DEFAULT 0,
  `submissionstart` bigint(10) DEFAULT 0,
  `submissionend` bigint(10) DEFAULT 0,
  `assessmentstart` bigint(10) DEFAULT 0,
  `assessmentend` bigint(10) DEFAULT 0,
  `phaseswitchassessment` tinyint(2) NOT NULL DEFAULT 0,
  `conclusion` longtext DEFAULT NULL,
  `conclusionformat` smallint(3) NOT NULL DEFAULT 1,
  `overallfeedbackmode` smallint(3) DEFAULT 1,
  `overallfeedbackfiles` smallint(3) DEFAULT 0,
  `overallfeedbackfiletypes` varchar(255) DEFAULT NULL,
  `overallfeedbackmaxbytes` bigint(10) DEFAULT 100000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table keeps information about the module instances and ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopallocation_scheduled`
--

CREATE TABLE `mdlfx_workshopallocation_scheduled` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `enabled` tinyint(2) NOT NULL DEFAULT 0,
  `submissionend` bigint(10) NOT NULL,
  `timeallocated` bigint(10) DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `resultstatus` bigint(10) DEFAULT NULL,
  `resultmessage` varchar(1333) DEFAULT NULL,
  `resultlog` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the allocation settings for the scheduled allocator';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopeval_best_settings`
--

CREATE TABLE `mdlfx_workshopeval_best_settings` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `comparison` smallint(3) DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Settings for the grading evaluation subplugin Comparison wit';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopform_accumulative`
--

CREATE TABLE `mdlfx_workshopform_accumulative` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `sort` bigint(10) DEFAULT 0,
  `description` longtext DEFAULT NULL,
  `descriptionformat` smallint(3) DEFAULT 0,
  `grade` bigint(10) NOT NULL,
  `weight` mediumint(5) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The assessment dimensions definitions of Accumulative gradin';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopform_comments`
--

CREATE TABLE `mdlfx_workshopform_comments` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `sort` bigint(10) DEFAULT 0,
  `description` longtext DEFAULT NULL,
  `descriptionformat` smallint(3) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The assessment dimensions definitions of Comments strategy f';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopform_numerrors`
--

CREATE TABLE `mdlfx_workshopform_numerrors` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `sort` bigint(10) DEFAULT 0,
  `description` longtext DEFAULT NULL,
  `descriptionformat` smallint(3) DEFAULT 0,
  `descriptiontrust` bigint(10) DEFAULT NULL,
  `grade0` varchar(50) DEFAULT NULL,
  `grade1` varchar(50) DEFAULT NULL,
  `weight` mediumint(5) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The assessment dimensions definitions of Number of errors gr';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopform_numerrors_map`
--

CREATE TABLE `mdlfx_workshopform_numerrors_map` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `nonegative` bigint(10) NOT NULL,
  `grade` decimal(10,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This maps the number of errors to a percentual grade for sub';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopform_rubric`
--

CREATE TABLE `mdlfx_workshopform_rubric` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `sort` bigint(10) DEFAULT 0,
  `description` longtext DEFAULT NULL,
  `descriptionformat` smallint(3) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The assessment dimensions definitions of Rubric grading stra';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopform_rubric_config`
--

CREATE TABLE `mdlfx_workshopform_rubric_config` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `layout` varchar(30) DEFAULT 'list'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Configuration table for the Rubric grading strategy';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshopform_rubric_levels`
--

CREATE TABLE `mdlfx_workshopform_rubric_levels` (
  `id` bigint(10) NOT NULL,
  `dimensionid` bigint(10) NOT NULL,
  `grade` decimal(10,5) NOT NULL,
  `definition` longtext DEFAULT NULL,
  `definitionformat` smallint(3) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The definition of rubric rating scales';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshop_aggregations`
--

CREATE TABLE `mdlfx_workshop_aggregations` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `gradinggrade` decimal(10,5) DEFAULT NULL,
  `timegraded` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Aggregated grades for assessment are stored here. The aggreg';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshop_assessments`
--

CREATE TABLE `mdlfx_workshop_assessments` (
  `id` bigint(10) NOT NULL,
  `submissionid` bigint(10) NOT NULL,
  `reviewerid` bigint(10) NOT NULL,
  `weight` bigint(10) NOT NULL DEFAULT 1,
  `timecreated` bigint(10) DEFAULT 0,
  `timemodified` bigint(10) DEFAULT 0,
  `grade` decimal(10,5) DEFAULT NULL,
  `gradinggrade` decimal(10,5) DEFAULT NULL,
  `gradinggradeover` decimal(10,5) DEFAULT NULL,
  `gradinggradeoverby` bigint(10) DEFAULT NULL,
  `feedbackauthor` longtext DEFAULT NULL,
  `feedbackauthorformat` smallint(3) DEFAULT 0,
  `feedbackauthorattachment` smallint(3) DEFAULT 0,
  `feedbackreviewer` longtext DEFAULT NULL,
  `feedbackreviewerformat` smallint(3) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about the made assessment and automatically calculated ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshop_grades`
--

CREATE TABLE `mdlfx_workshop_grades` (
  `id` bigint(10) NOT NULL,
  `assessmentid` bigint(10) NOT NULL,
  `strategy` varchar(30) NOT NULL DEFAULT '',
  `dimensionid` bigint(10) NOT NULL,
  `grade` decimal(10,5) NOT NULL,
  `peercomment` longtext DEFAULT NULL,
  `peercommentformat` smallint(3) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='How the reviewers filled-up the grading forms, given grades ';

-- --------------------------------------------------------

--
-- Table structure for table `mdlfx_workshop_submissions`
--

CREATE TABLE `mdlfx_workshop_submissions` (
  `id` bigint(10) NOT NULL,
  `workshopid` bigint(10) NOT NULL,
  `example` tinyint(2) DEFAULT 0,
  `authorid` bigint(10) NOT NULL,
  `timecreated` bigint(10) NOT NULL,
  `timemodified` bigint(10) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` longtext DEFAULT NULL,
  `contentformat` smallint(3) NOT NULL DEFAULT 0,
  `contenttrust` smallint(3) NOT NULL DEFAULT 0,
  `attachment` tinyint(2) DEFAULT 0,
  `grade` decimal(10,5) DEFAULT NULL,
  `gradeover` decimal(10,5) DEFAULT NULL,
  `gradeoverby` bigint(10) DEFAULT NULL,
  `feedbackauthor` longtext DEFAULT NULL,
  `feedbackauthorformat` smallint(3) DEFAULT 0,
  `timegraded` bigint(10) DEFAULT NULL,
  `published` tinyint(2) DEFAULT 0,
  `late` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Info about the submission and the aggregation of the grade f';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mdlfx_analytics_indicator_calc`
--
ALTER TABLE `mdlfx_analytics_indicator_calc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analindicalc_staendco_ix` (`starttime`,`endtime`,`contextid`),
  ADD KEY `mdlfx_analindicalc_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_analytics_models`
--
ALTER TABLE `mdlfx_analytics_models`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analmode_enatra_ix` (`enabled`,`trained`);

--
-- Indexes for table `mdlfx_analytics_models_log`
--
ALTER TABLE `mdlfx_analytics_models_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analmodelog_mod_ix` (`modelid`);

--
-- Indexes for table `mdlfx_analytics_predictions`
--
ALTER TABLE `mdlfx_analytics_predictions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analpred_modcon_ix` (`modelid`,`contextid`),
  ADD KEY `mdlfx_analpred_mod_ix` (`modelid`),
  ADD KEY `mdlfx_analpred_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_analytics_prediction_actions`
--
ALTER TABLE `mdlfx_analytics_prediction_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analpredacti_preuseac_ix` (`predictionid`,`userid`,`actionname`),
  ADD KEY `mdlfx_analpredacti_pre_ix` (`predictionid`),
  ADD KEY `mdlfx_analpredacti_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_analytics_predict_samples`
--
ALTER TABLE `mdlfx_analytics_predict_samples`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analpredsamp_modanati_ix` (`modelid`,`analysableid`,`timesplitting`,`rangeindex`),
  ADD KEY `mdlfx_analpredsamp_mod_ix` (`modelid`);

--
-- Indexes for table `mdlfx_analytics_train_samples`
--
ALTER TABLE `mdlfx_analytics_train_samples`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analtraisamp_modanati_ix` (`modelid`,`analysableid`,`timesplitting`),
  ADD KEY `mdlfx_analtraisamp_mod_ix` (`modelid`);

--
-- Indexes for table `mdlfx_analytics_used_analysables`
--
ALTER TABLE `mdlfx_analytics_used_analysables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analusedanal_modact_ix` (`modelid`,`action`),
  ADD KEY `mdlfx_analusedanal_ana_ix` (`analysableid`),
  ADD KEY `mdlfx_analusedanal_mod_ix` (`modelid`);

--
-- Indexes for table `mdlfx_analytics_used_files`
--
ALTER TABLE `mdlfx_analytics_used_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_analusedfile_modactfi_ix` (`modelid`,`action`,`fileid`),
  ADD KEY `mdlfx_analusedfile_mod_ix` (`modelid`),
  ADD KEY `mdlfx_analusedfile_fil_ix` (`fileid`);

--
-- Indexes for table `mdlfx_assign`
--
ALTER TABLE `mdlfx_assign`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assi_cou_ix` (`course`),
  ADD KEY `mdlfx_assi_tea_ix` (`teamsubmissiongroupingid`);

--
-- Indexes for table `mdlfx_assignfeedback_comments`
--
ALTER TABLE `mdlfx_assignfeedback_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assicomm_ass_ix` (`assignment`),
  ADD KEY `mdlfx_assicomm_gra_ix` (`grade`);

--
-- Indexes for table `mdlfx_assignfeedback_editpdf_annot`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_annot`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assieditanno_grapag_ix` (`gradeid`,`pageno`),
  ADD KEY `mdlfx_assieditanno_gra_ix` (`gradeid`);

--
-- Indexes for table `mdlfx_assignfeedback_editpdf_cmnt`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_cmnt`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assieditcmnt_grapag_ix` (`gradeid`,`pageno`),
  ADD KEY `mdlfx_assieditcmnt_gra_ix` (`gradeid`);

--
-- Indexes for table `mdlfx_assignfeedback_editpdf_queue`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_queue`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_assieditqueu_subsub_uix` (`submissionid`,`submissionattempt`);

--
-- Indexes for table `mdlfx_assignfeedback_editpdf_quick`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_quick`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assieditquic_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_assignfeedback_editpdf_rot`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_rot`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_assieditrot_grapag_uix` (`gradeid`,`pageno`),
  ADD KEY `mdlfx_assieditrot_gra_ix` (`gradeid`);

--
-- Indexes for table `mdlfx_assignfeedback_file`
--
ALTER TABLE `mdlfx_assignfeedback_file`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assifile_ass2_ix` (`assignment`),
  ADD KEY `mdlfx_assifile_gra_ix` (`grade`);

--
-- Indexes for table `mdlfx_assignment`
--
ALTER TABLE `mdlfx_assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assi_cou2_ix` (`course`);

--
-- Indexes for table `mdlfx_assignment_submissions`
--
ALTER TABLE `mdlfx_assignment_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assisubm_use2_ix` (`userid`),
  ADD KEY `mdlfx_assisubm_mai_ix` (`mailed`),
  ADD KEY `mdlfx_assisubm_tim_ix` (`timemarked`),
  ADD KEY `mdlfx_assisubm_ass2_ix` (`assignment`);

--
-- Indexes for table `mdlfx_assignment_upgrade`
--
ALTER TABLE `mdlfx_assignment_upgrade`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assiupgr_old_ix` (`oldcmid`),
  ADD KEY `mdlfx_assiupgr_old2_ix` (`oldinstance`);

--
-- Indexes for table `mdlfx_assignsubmission_file`
--
ALTER TABLE `mdlfx_assignsubmission_file`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assifile_ass_ix` (`assignment`),
  ADD KEY `mdlfx_assifile_sub_ix` (`submission`);

--
-- Indexes for table `mdlfx_assignsubmission_onlinetext`
--
ALTER TABLE `mdlfx_assignsubmission_onlinetext`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assionli_ass_ix` (`assignment`),
  ADD KEY `mdlfx_assionli_sub_ix` (`submission`);

--
-- Indexes for table `mdlfx_assign_grades`
--
ALTER TABLE `mdlfx_assign_grades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_assigrad_assuseatt_uix` (`assignment`,`userid`,`attemptnumber`),
  ADD KEY `mdlfx_assigrad_use_ix` (`userid`),
  ADD KEY `mdlfx_assigrad_att_ix` (`attemptnumber`),
  ADD KEY `mdlfx_assigrad_ass_ix` (`assignment`);

--
-- Indexes for table `mdlfx_assign_overrides`
--
ALTER TABLE `mdlfx_assign_overrides`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assiover_ass_ix` (`assignid`),
  ADD KEY `mdlfx_assiover_gro_ix` (`groupid`),
  ADD KEY `mdlfx_assiover_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_assign_plugin_config`
--
ALTER TABLE `mdlfx_assign_plugin_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assiplugconf_plu_ix` (`plugin`),
  ADD KEY `mdlfx_assiplugconf_sub_ix` (`subtype`),
  ADD KEY `mdlfx_assiplugconf_nam_ix` (`name`),
  ADD KEY `mdlfx_assiplugconf_ass_ix` (`assignment`);

--
-- Indexes for table `mdlfx_assign_submission`
--
ALTER TABLE `mdlfx_assign_submission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_assisubm_assusegroat_uix` (`assignment`,`userid`,`groupid`,`attemptnumber`),
  ADD KEY `mdlfx_assisubm_use_ix` (`userid`),
  ADD KEY `mdlfx_assisubm_att_ix` (`attemptnumber`),
  ADD KEY `mdlfx_assisubm_assusegrolat_ix` (`assignment`,`userid`,`groupid`,`latest`),
  ADD KEY `mdlfx_assisubm_ass_ix` (`assignment`);

--
-- Indexes for table `mdlfx_assign_user_flags`
--
ALTER TABLE `mdlfx_assign_user_flags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assiuserflag_mai_ix` (`mailed`),
  ADD KEY `mdlfx_assiuserflag_use_ix` (`userid`),
  ADD KEY `mdlfx_assiuserflag_ass_ix` (`assignment`);

--
-- Indexes for table `mdlfx_assign_user_mapping`
--
ALTER TABLE `mdlfx_assign_user_mapping`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_assiusermapp_ass_ix` (`assignment`),
  ADD KEY `mdlfx_assiusermapp_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_attendance`
--
ALTER TABLE `mdlfx_attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_atte_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_attendance_log`
--
ALTER TABLE `mdlfx_attendance_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_attelog_ses_ix` (`sessionid`),
  ADD KEY `mdlfx_attelog_stu_ix` (`studentid`),
  ADD KEY `mdlfx_attelog_sta_ix` (`statusid`);

--
-- Indexes for table `mdlfx_attendance_rotate_passwords`
--
ALTER TABLE `mdlfx_attendance_rotate_passwords`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_attendance_sessions`
--
ALTER TABLE `mdlfx_attendance_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_attesess_att_ix` (`attendanceid`),
  ADD KEY `mdlfx_attesess_gro_ix` (`groupid`),
  ADD KEY `mdlfx_attesess_ses_ix` (`sessdate`),
  ADD KEY `mdlfx_attesess_cal_ix` (`caleventid`);

--
-- Indexes for table `mdlfx_attendance_statuses`
--
ALTER TABLE `mdlfx_attendance_statuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_attestat_att_ix` (`attendanceid`),
  ADD KEY `mdlfx_attestat_vis_ix` (`visible`),
  ADD KEY `mdlfx_attestat_del_ix` (`deleted`);

--
-- Indexes for table `mdlfx_attendance_tempusers`
--
ALTER TABLE `mdlfx_attendance_tempusers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_attetemp_stu_uix` (`studentid`),
  ADD KEY `mdlfx_attetemp_cou_ix` (`courseid`);

--
-- Indexes for table `mdlfx_attendance_warning`
--
ALTER TABLE `mdlfx_attendance_warning`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_attewarn_idnwarwar_uix` (`idnumber`,`warningpercent`,`warnafter`);

--
-- Indexes for table `mdlfx_attendance_warning_done`
--
ALTER TABLE `mdlfx_attendance_warning_done`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_attewarndone_notuse_ix` (`notifyid`,`userid`);

--
-- Indexes for table `mdlfx_auth_oauth2_linked_login`
--
ALTER TABLE `mdlfx_auth_oauth2_linked_login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_authoautlinklogi_use_uix` (`userid`,`issuerid`,`username`),
  ADD KEY `mdlfx_authoautlinklogi_issu_ix` (`issuerid`,`username`),
  ADD KEY `mdlfx_authoautlinklogi_use_ix` (`usermodified`),
  ADD KEY `mdlfx_authoautlinklogi_use2_ix` (`userid`),
  ADD KEY `mdlfx_authoautlinklogi_iss_ix` (`issuerid`);

--
-- Indexes for table `mdlfx_backup_controllers`
--
ALTER TABLE `mdlfx_backup_controllers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_backcont_bac_uix` (`backupid`),
  ADD KEY `mdlfx_backcont_typite_ix` (`type`,`itemid`),
  ADD KEY `mdlfx_backcont_useite_ix` (`userid`,`itemid`),
  ADD KEY `mdlfx_backcont_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_backup_courses`
--
ALTER TABLE `mdlfx_backup_courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_backcour_cou_uix` (`courseid`);

--
-- Indexes for table `mdlfx_backup_logs`
--
ALTER TABLE `mdlfx_backup_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_backlogs_bacid_uix` (`backupid`,`id`),
  ADD KEY `mdlfx_backlogs_bac_ix` (`backupid`);

--
-- Indexes for table `mdlfx_badge`
--
ALTER TABLE `mdlfx_badge`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_badg_typ_ix` (`type`),
  ADD KEY `mdlfx_badg_cou_ix` (`courseid`),
  ADD KEY `mdlfx_badg_use_ix` (`usermodified`),
  ADD KEY `mdlfx_badg_use2_ix` (`usercreated`);

--
-- Indexes for table `mdlfx_badge_alignment`
--
ALTER TABLE `mdlfx_badge_alignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_badgalig_bad_ix` (`badgeid`);

--
-- Indexes for table `mdlfx_badge_backpack`
--
ALTER TABLE `mdlfx_badge_backpack`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_badgback_use_ix` (`userid`),
  ADD KEY `mdlfx_badgback_ext_ix` (`externalbackpackid`);

--
-- Indexes for table `mdlfx_badge_criteria`
--
ALTER TABLE `mdlfx_badge_criteria`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_badgcrit_badcri_uix` (`badgeid`,`criteriatype`),
  ADD KEY `mdlfx_badgcrit_cri_ix` (`criteriatype`),
  ADD KEY `mdlfx_badgcrit_bad_ix` (`badgeid`);

--
-- Indexes for table `mdlfx_badge_criteria_met`
--
ALTER TABLE `mdlfx_badge_criteria_met`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_badgcritmet_cri_ix` (`critid`),
  ADD KEY `mdlfx_badgcritmet_use_ix` (`userid`),
  ADD KEY `mdlfx_badgcritmet_iss_ix` (`issuedid`);

--
-- Indexes for table `mdlfx_badge_criteria_param`
--
ALTER TABLE `mdlfx_badge_criteria_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_badgcritpara_cri_ix` (`critid`);

--
-- Indexes for table `mdlfx_badge_endorsement`
--
ALTER TABLE `mdlfx_badge_endorsement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_badgendo_bad_ix` (`badgeid`);

--
-- Indexes for table `mdlfx_badge_external`
--
ALTER TABLE `mdlfx_badge_external`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_badgexte_bac_ix` (`backpackid`);

--
-- Indexes for table `mdlfx_badge_external_backpack`
--
ALTER TABLE `mdlfx_badge_external_backpack`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_badgexteback_bac_uix` (`backpackapiurl`),
  ADD UNIQUE KEY `mdlfx_badgexteback_bac2_uix` (`backpackweburl`);

--
-- Indexes for table `mdlfx_badge_external_identifier`
--
ALTER TABLE `mdlfx_badge_external_identifier`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_badgexteiden_sitinte_uix` (`sitebackpackid`,`internalid`,`externalid`,`type`),
  ADD KEY `mdlfx_badgexteiden_sit_ix` (`sitebackpackid`);

--
-- Indexes for table `mdlfx_badge_issued`
--
ALTER TABLE `mdlfx_badge_issued`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_badgissu_baduse_uix` (`badgeid`,`userid`),
  ADD KEY `mdlfx_badgissu_bad_ix` (`badgeid`),
  ADD KEY `mdlfx_badgissu_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_badge_manual_award`
--
ALTER TABLE `mdlfx_badge_manual_award`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_badgmanuawar_bad_ix` (`badgeid`),
  ADD KEY `mdlfx_badgmanuawar_rec_ix` (`recipientid`),
  ADD KEY `mdlfx_badgmanuawar_iss_ix` (`issuerid`),
  ADD KEY `mdlfx_badgmanuawar_iss2_ix` (`issuerrole`);

--
-- Indexes for table `mdlfx_badge_related`
--
ALTER TABLE `mdlfx_badge_related`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_badgrela_badrel_uix` (`badgeid`,`relatedbadgeid`),
  ADD KEY `mdlfx_badgrela_bad_ix` (`badgeid`),
  ADD KEY `mdlfx_badgrela_rel_ix` (`relatedbadgeid`);

--
-- Indexes for table `mdlfx_block`
--
ALTER TABLE `mdlfx_block`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_bloc_nam_uix` (`name`);

--
-- Indexes for table `mdlfx_block_instances`
--
ALTER TABLE `mdlfx_block_instances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_blocinst_parshopagsub_ix` (`parentcontextid`,`showinsubcontexts`,`pagetypepattern`,`subpagepattern`),
  ADD KEY `mdlfx_blocinst_tim_ix` (`timemodified`),
  ADD KEY `mdlfx_blocinst_par_ix` (`parentcontextid`);

--
-- Indexes for table `mdlfx_block_positions`
--
ALTER TABLE `mdlfx_block_positions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_blocposi_bloconpagsu_uix` (`blockinstanceid`,`contextid`,`pagetype`,`subpage`),
  ADD KEY `mdlfx_blocposi_blo_ix` (`blockinstanceid`),
  ADD KEY `mdlfx_blocposi_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_block_recentlyaccesseditems`
--
ALTER TABLE `mdlfx_block_recentlyaccesseditems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_blocrece_usecoucmi_uix` (`userid`,`courseid`,`cmid`),
  ADD KEY `mdlfx_blocrece_use_ix` (`userid`),
  ADD KEY `mdlfx_blocrece_cou_ix` (`courseid`),
  ADD KEY `mdlfx_blocrece_cmi_ix` (`cmid`);

--
-- Indexes for table `mdlfx_block_recent_activity`
--
ALTER TABLE `mdlfx_block_recent_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_blocreceacti_coutim_ix` (`courseid`,`timecreated`);

--
-- Indexes for table `mdlfx_block_rss_client`
--
ALTER TABLE `mdlfx_block_rss_client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_blog_association`
--
ALTER TABLE `mdlfx_blog_association`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_blogasso_con_ix` (`contextid`),
  ADD KEY `mdlfx_blogasso_blo_ix` (`blogid`);

--
-- Indexes for table `mdlfx_blog_external`
--
ALTER TABLE `mdlfx_blog_external`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_blogexte_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_book`
--
ALTER TABLE `mdlfx_book`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_book_chapters`
--
ALTER TABLE `mdlfx_book_chapters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_cache_filters`
--
ALTER TABLE `mdlfx_cache_filters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_cachfilt_filmd5_ix` (`filter`,`md5key`);

--
-- Indexes for table `mdlfx_cache_flags`
--
ALTER TABLE `mdlfx_cache_flags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_cachflag_fla_ix` (`flagtype`),
  ADD KEY `mdlfx_cachflag_nam_ix` (`name`);

--
-- Indexes for table `mdlfx_capabilities`
--
ALTER TABLE `mdlfx_capabilities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_capa_nam_uix` (`name`);

--
-- Indexes for table `mdlfx_chat`
--
ALTER TABLE `mdlfx_chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_chat_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_chat_messages`
--
ALTER TABLE `mdlfx_chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_chatmess_use_ix` (`userid`),
  ADD KEY `mdlfx_chatmess_gro_ix` (`groupid`),
  ADD KEY `mdlfx_chatmess_timcha_ix` (`timestamp`,`chatid`),
  ADD KEY `mdlfx_chatmess_cha_ix` (`chatid`);

--
-- Indexes for table `mdlfx_chat_messages_current`
--
ALTER TABLE `mdlfx_chat_messages_current`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_chatmesscurr_use_ix` (`userid`),
  ADD KEY `mdlfx_chatmesscurr_gro_ix` (`groupid`),
  ADD KEY `mdlfx_chatmesscurr_timcha_ix` (`timestamp`,`chatid`),
  ADD KEY `mdlfx_chatmesscurr_cha_ix` (`chatid`);

--
-- Indexes for table `mdlfx_chat_users`
--
ALTER TABLE `mdlfx_chat_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_chatuser_use_ix` (`userid`),
  ADD KEY `mdlfx_chatuser_las_ix` (`lastping`),
  ADD KEY `mdlfx_chatuser_gro_ix` (`groupid`),
  ADD KEY `mdlfx_chatuser_cha_ix` (`chatid`);

--
-- Indexes for table `mdlfx_choice`
--
ALTER TABLE `mdlfx_choice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_choi_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_choice_answers`
--
ALTER TABLE `mdlfx_choice_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_choiansw_use_ix` (`userid`),
  ADD KEY `mdlfx_choiansw_cho_ix` (`choiceid`),
  ADD KEY `mdlfx_choiansw_opt_ix` (`optionid`);

--
-- Indexes for table `mdlfx_choice_options`
--
ALTER TABLE `mdlfx_choice_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_choiopti_cho_ix` (`choiceid`);

--
-- Indexes for table `mdlfx_cohort`
--
ALTER TABLE `mdlfx_cohort`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_coho_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_cohort_members`
--
ALTER TABLE `mdlfx_cohort_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_cohomemb_cohuse_uix` (`cohortid`,`userid`),
  ADD KEY `mdlfx_cohomemb_coh_ix` (`cohortid`),
  ADD KEY `mdlfx_cohomemb_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_comments`
--
ALTER TABLE `mdlfx_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_comm_concomite_ix` (`contextid`,`commentarea`,`itemid`),
  ADD KEY `mdlfx_comm_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_competency`
--
ALTER TABLE `mdlfx_competency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_comp_comidn_uix` (`competencyframeworkid`,`idnumber`),
  ADD KEY `mdlfx_comp_rul_ix` (`ruleoutcome`);

--
-- Indexes for table `mdlfx_competency_coursecomp`
--
ALTER TABLE `mdlfx_competency_coursecomp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compcour_coucom_uix` (`courseid`,`competencyid`),
  ADD KEY `mdlfx_compcour_courul_ix` (`courseid`,`ruleoutcome`),
  ADD KEY `mdlfx_compcour_cou2_ix` (`courseid`),
  ADD KEY `mdlfx_compcour_com_ix` (`competencyid`);

--
-- Indexes for table `mdlfx_competency_coursecompsetting`
--
ALTER TABLE `mdlfx_competency_coursecompsetting`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compcour_cou_uix` (`courseid`);

--
-- Indexes for table `mdlfx_competency_evidence`
--
ALTER TABLE `mdlfx_competency_evidence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_compevid_use_ix` (`usercompetencyid`);

--
-- Indexes for table `mdlfx_competency_framework`
--
ALTER TABLE `mdlfx_competency_framework`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compfram_idn_uix` (`idnumber`);

--
-- Indexes for table `mdlfx_competency_modulecomp`
--
ALTER TABLE `mdlfx_competency_modulecomp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compmodu_cmicom_uix` (`cmid`,`competencyid`),
  ADD KEY `mdlfx_compmodu_cmirul_ix` (`cmid`,`ruleoutcome`),
  ADD KEY `mdlfx_compmodu_cmi_ix` (`cmid`),
  ADD KEY `mdlfx_compmodu_com_ix` (`competencyid`);

--
-- Indexes for table `mdlfx_competency_plan`
--
ALTER TABLE `mdlfx_competency_plan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_compplan_usesta_ix` (`userid`,`status`),
  ADD KEY `mdlfx_compplan_tem_ix` (`templateid`),
  ADD KEY `mdlfx_compplan_stadue_ix` (`status`,`duedate`);

--
-- Indexes for table `mdlfx_competency_plancomp`
--
ALTER TABLE `mdlfx_competency_plancomp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compplan_placom_uix` (`planid`,`competencyid`);

--
-- Indexes for table `mdlfx_competency_relatedcomp`
--
ALTER TABLE `mdlfx_competency_relatedcomp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_competency_template`
--
ALTER TABLE `mdlfx_competency_template`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_competency_templatecohort`
--
ALTER TABLE `mdlfx_competency_templatecohort`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_comptemp_temcoh_uix` (`templateid`,`cohortid`),
  ADD KEY `mdlfx_comptemp_tem2_ix` (`templateid`);

--
-- Indexes for table `mdlfx_competency_templatecomp`
--
ALTER TABLE `mdlfx_competency_templatecomp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_comptemp_tem_ix` (`templateid`),
  ADD KEY `mdlfx_comptemp_com_ix` (`competencyid`);

--
-- Indexes for table `mdlfx_competency_usercomp`
--
ALTER TABLE `mdlfx_competency_usercomp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compuser_usecom_uix` (`userid`,`competencyid`);

--
-- Indexes for table `mdlfx_competency_usercompcourse`
--
ALTER TABLE `mdlfx_competency_usercompcourse`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compuser_usecoucom_uix` (`userid`,`courseid`,`competencyid`);

--
-- Indexes for table `mdlfx_competency_usercompplan`
--
ALTER TABLE `mdlfx_competency_usercompplan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compuser_usecompla_uix` (`userid`,`competencyid`,`planid`);

--
-- Indexes for table `mdlfx_competency_userevidence`
--
ALTER TABLE `mdlfx_competency_userevidence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_compuser_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_competency_userevidencecomp`
--
ALTER TABLE `mdlfx_competency_userevidencecomp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_compuser_usecom2_uix` (`userevidenceid`,`competencyid`),
  ADD KEY `mdlfx_compuser_use2_ix` (`userevidenceid`);

--
-- Indexes for table `mdlfx_config`
--
ALTER TABLE `mdlfx_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_conf_nam_uix` (`name`);

--
-- Indexes for table `mdlfx_config_log`
--
ALTER TABLE `mdlfx_config_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_conflog_tim_ix` (`timemodified`),
  ADD KEY `mdlfx_conflog_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_config_plugins`
--
ALTER TABLE `mdlfx_config_plugins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_confplug_plunam_uix` (`plugin`,`name`);

--
-- Indexes for table `mdlfx_context`
--
ALTER TABLE `mdlfx_context`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_cont_conins_uix` (`contextlevel`,`instanceid`),
  ADD KEY `mdlfx_cont_ins_ix` (`instanceid`),
  ADD KEY `mdlfx_cont_pat_ix` (`path`);

--
-- Indexes for table `mdlfx_context_temp`
--
ALTER TABLE `mdlfx_context_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_course`
--
ALTER TABLE `mdlfx_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_cour_cat_ix` (`category`),
  ADD KEY `mdlfx_cour_idn_ix` (`idnumber`),
  ADD KEY `mdlfx_cour_sho_ix` (`shortname`),
  ADD KEY `mdlfx_cour_sor_ix` (`sortorder`);

--
-- Indexes for table `mdlfx_course_categories`
--
ALTER TABLE `mdlfx_course_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_courcate_par_ix` (`parent`);

--
-- Indexes for table `mdlfx_course_completions`
--
ALTER TABLE `mdlfx_course_completions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_courcomp_usecou_uix` (`userid`,`course`),
  ADD KEY `mdlfx_courcomp_use_ix` (`userid`),
  ADD KEY `mdlfx_courcomp_cou_ix` (`course`),
  ADD KEY `mdlfx_courcomp_tim_ix` (`timecompleted`);

--
-- Indexes for table `mdlfx_course_completion_aggr_methd`
--
ALTER TABLE `mdlfx_course_completion_aggr_methd`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_courcompaggrmeth_cou_uix` (`course`,`criteriatype`),
  ADD KEY `mdlfx_courcompaggrmeth_cou_ix` (`course`),
  ADD KEY `mdlfx_courcompaggrmeth_cri_ix` (`criteriatype`);

--
-- Indexes for table `mdlfx_course_completion_criteria`
--
ALTER TABLE `mdlfx_course_completion_criteria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_courcompcrit_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_course_completion_crit_compl`
--
ALTER TABLE `mdlfx_course_completion_crit_compl`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_courcompcritcomp_use_uix` (`userid`,`course`,`criteriaid`),
  ADD KEY `mdlfx_courcompcritcomp_use_ix` (`userid`),
  ADD KEY `mdlfx_courcompcritcomp_cou_ix` (`course`),
  ADD KEY `mdlfx_courcompcritcomp_cri_ix` (`criteriaid`),
  ADD KEY `mdlfx_courcompcritcomp_tim_ix` (`timecompleted`);

--
-- Indexes for table `mdlfx_course_completion_defaults`
--
ALTER TABLE `mdlfx_course_completion_defaults`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_courcompdefa_coumod_uix` (`course`,`module`),
  ADD KEY `mdlfx_courcompdefa_mod_ix` (`module`),
  ADD KEY `mdlfx_courcompdefa_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_course_format_options`
--
ALTER TABLE `mdlfx_course_format_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_courformopti_coufors_uix` (`courseid`,`format`,`sectionid`,`name`),
  ADD KEY `mdlfx_courformopti_cou_ix` (`courseid`);

--
-- Indexes for table `mdlfx_course_modules`
--
ALTER TABLE `mdlfx_course_modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_courmodu_vis_ix` (`visible`),
  ADD KEY `mdlfx_courmodu_cou_ix` (`course`),
  ADD KEY `mdlfx_courmodu_mod_ix` (`module`),
  ADD KEY `mdlfx_courmodu_ins_ix` (`instance`),
  ADD KEY `mdlfx_courmodu_idncou_ix` (`idnumber`,`course`),
  ADD KEY `mdlfx_courmodu_gro_ix` (`groupingid`);

--
-- Indexes for table `mdlfx_course_modules_completion`
--
ALTER TABLE `mdlfx_course_modules_completion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_courmoducomp_usecou_uix` (`userid`,`coursemoduleid`),
  ADD KEY `mdlfx_courmoducomp_cou_ix` (`coursemoduleid`);

--
-- Indexes for table `mdlfx_course_published`
--
ALTER TABLE `mdlfx_course_published`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_course_request`
--
ALTER TABLE `mdlfx_course_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_courrequ_sho_ix` (`shortname`);

--
-- Indexes for table `mdlfx_course_sections`
--
ALTER TABLE `mdlfx_course_sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_coursect_cousec_uix` (`course`,`section`);

--
-- Indexes for table `mdlfx_customfield_category`
--
ALTER TABLE `mdlfx_customfield_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_custcate_comareitesor_ix` (`component`,`area`,`itemid`,`sortorder`),
  ADD KEY `mdlfx_custcate_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_customfield_data`
--
ALTER TABLE `mdlfx_customfield_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_custdata_insfie_uix` (`instanceid`,`fieldid`),
  ADD KEY `mdlfx_custdata_fieint_ix` (`fieldid`,`intvalue`),
  ADD KEY `mdlfx_custdata_fiesho_ix` (`fieldid`,`shortcharvalue`),
  ADD KEY `mdlfx_custdata_fiedec_ix` (`fieldid`,`decvalue`),
  ADD KEY `mdlfx_custdata_fie_ix` (`fieldid`),
  ADD KEY `mdlfx_custdata_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_customfield_field`
--
ALTER TABLE `mdlfx_customfield_field`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_custfiel_catsor_ix` (`categoryid`,`sortorder`),
  ADD KEY `mdlfx_custfiel_cat_ix` (`categoryid`);

--
-- Indexes for table `mdlfx_data`
--
ALTER TABLE `mdlfx_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_data_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_data_content`
--
ALTER TABLE `mdlfx_data_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_datacont_rec_ix` (`recordid`),
  ADD KEY `mdlfx_datacont_fie_ix` (`fieldid`);

--
-- Indexes for table `mdlfx_data_fields`
--
ALTER TABLE `mdlfx_data_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_datafiel_typdat_ix` (`type`,`dataid`),
  ADD KEY `mdlfx_datafiel_dat_ix` (`dataid`);

--
-- Indexes for table `mdlfx_data_records`
--
ALTER TABLE `mdlfx_data_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_datareco_dat_ix` (`dataid`);

--
-- Indexes for table `mdlfx_editor_atto_autosave`
--
ALTER TABLE `mdlfx_editor_atto_autosave`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_editattoauto_eleconu_uix` (`elementid`,`contextid`,`userid`,`pagehash`);

--
-- Indexes for table `mdlfx_enrol`
--
ALTER TABLE `mdlfx_enrol`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enro_enr_ix` (`enrol`),
  ADD KEY `mdlfx_enro_cou_ix` (`courseid`);

--
-- Indexes for table `mdlfx_enrol_flatfile`
--
ALTER TABLE `mdlfx_enrol_flatfile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enroflat_cou_ix` (`courseid`),
  ADD KEY `mdlfx_enroflat_use_ix` (`userid`),
  ADD KEY `mdlfx_enroflat_rol_ix` (`roleid`);

--
-- Indexes for table `mdlfx_enrol_lti_lti2_consumer`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_consumer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_enroltilti2cons_con_uix` (`consumerkey256`);

--
-- Indexes for table `mdlfx_enrol_lti_lti2_context`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_context`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enroltilti2cont_con_ix` (`consumerid`);

--
-- Indexes for table `mdlfx_enrol_lti_lti2_nonce`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_nonce`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enroltilti2nonc_con_ix` (`consumerid`);

--
-- Indexes for table `mdlfx_enrol_lti_lti2_resource_link`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_resource_link`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enroltilti2resolink_c_ix` (`contextid`),
  ADD KEY `mdlfx_enroltilti2resolink_p_ix` (`primaryresourcelinkid`),
  ADD KEY `mdlfx_enroltilti2resolink_2_ix` (`consumerid`);

--
-- Indexes for table `mdlfx_enrol_lti_lti2_share_key`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_share_key`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_enroltilti2sharkey_s_uix` (`sharekey`),
  ADD UNIQUE KEY `mdlfx_enroltilti2sharkey_r_uix` (`resourcelinkid`);

--
-- Indexes for table `mdlfx_enrol_lti_lti2_tool_proxy`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_tool_proxy`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_enroltilti2toolprox__uix` (`toolproxykey`),
  ADD KEY `mdlfx_enroltilti2toolprox_c_ix` (`consumerid`);

--
-- Indexes for table `mdlfx_enrol_lti_lti2_user_result`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_user_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enroltilti2userresu_r_ix` (`resourcelinkid`);

--
-- Indexes for table `mdlfx_enrol_lti_tools`
--
ALTER TABLE `mdlfx_enrol_lti_tools`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enroltitool_enr_ix` (`enrolid`),
  ADD KEY `mdlfx_enroltitool_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_enrol_lti_tool_consumer_map`
--
ALTER TABLE `mdlfx_enrol_lti_tool_consumer_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enroltitoolconsmap_to_ix` (`toolid`),
  ADD KEY `mdlfx_enroltitoolconsmap_co_ix` (`consumerid`);

--
-- Indexes for table `mdlfx_enrol_lti_users`
--
ALTER TABLE `mdlfx_enrol_lti_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enroltiuser_use_ix` (`userid`),
  ADD KEY `mdlfx_enroltiuser_too_ix` (`toolid`);

--
-- Indexes for table `mdlfx_enrol_paypal`
--
ALTER TABLE `mdlfx_enrol_paypal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_enropayp_bus_ix` (`business`),
  ADD KEY `mdlfx_enropayp_rec_ix` (`receiver_email`),
  ADD KEY `mdlfx_enropayp_cou_ix` (`courseid`),
  ADD KEY `mdlfx_enropayp_use_ix` (`userid`),
  ADD KEY `mdlfx_enropayp_ins_ix` (`instanceid`);

--
-- Indexes for table `mdlfx_event`
--
ALTER TABLE `mdlfx_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_even_cou_ix` (`courseid`),
  ADD KEY `mdlfx_even_use_ix` (`userid`),
  ADD KEY `mdlfx_even_tim_ix` (`timestart`),
  ADD KEY `mdlfx_even_tim2_ix` (`timeduration`),
  ADD KEY `mdlfx_even_uui_ix` (`uuid`),
  ADD KEY `mdlfx_even_typtim_ix` (`type`,`timesort`),
  ADD KEY `mdlfx_even_grocoucatvisuse_ix` (`groupid`,`courseid`,`categoryid`,`visible`,`userid`),
  ADD KEY `mdlfx_even_cat_ix` (`categoryid`),
  ADD KEY `mdlfx_even_sub_ix` (`subscriptionid`);

--
-- Indexes for table `mdlfx_events_handlers`
--
ALTER TABLE `mdlfx_events_handlers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_evenhand_evecom_uix` (`eventname`,`component`);

--
-- Indexes for table `mdlfx_events_queue`
--
ALTER TABLE `mdlfx_events_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_evenqueu_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_events_queue_handlers`
--
ALTER TABLE `mdlfx_events_queue_handlers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_evenqueuhand_que_ix` (`queuedeventid`),
  ADD KEY `mdlfx_evenqueuhand_han_ix` (`handlerid`);

--
-- Indexes for table `mdlfx_event_subscriptions`
--
ALTER TABLE `mdlfx_event_subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_external_functions`
--
ALTER TABLE `mdlfx_external_functions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_extefunc_nam_uix` (`name`);

--
-- Indexes for table `mdlfx_external_services`
--
ALTER TABLE `mdlfx_external_services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_exteserv_nam_uix` (`name`);

--
-- Indexes for table `mdlfx_external_services_functions`
--
ALTER TABLE `mdlfx_external_services_functions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_exteservfunc_ext_ix` (`externalserviceid`);

--
-- Indexes for table `mdlfx_external_services_users`
--
ALTER TABLE `mdlfx_external_services_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_exteservuser_ext_ix` (`externalserviceid`),
  ADD KEY `mdlfx_exteservuser_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_external_tokens`
--
ALTER TABLE `mdlfx_external_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_extetoke_use_ix` (`userid`),
  ADD KEY `mdlfx_extetoke_ext_ix` (`externalserviceid`),
  ADD KEY `mdlfx_extetoke_con_ix` (`contextid`),
  ADD KEY `mdlfx_extetoke_cre_ix` (`creatorid`);

--
-- Indexes for table `mdlfx_favourite`
--
ALTER TABLE `mdlfx_favourite`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_favo_comiteiteconuse_uix` (`component`,`itemtype`,`itemid`,`contextid`,`userid`),
  ADD KEY `mdlfx_favo_con_ix` (`contextid`),
  ADD KEY `mdlfx_favo_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_feedback`
--
ALTER TABLE `mdlfx_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_feed_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_feedback_completed`
--
ALTER TABLE `mdlfx_feedback_completed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_feedcomp_use_ix` (`userid`),
  ADD KEY `mdlfx_feedcomp_fee_ix` (`feedback`);

--
-- Indexes for table `mdlfx_feedback_completedtmp`
--
ALTER TABLE `mdlfx_feedback_completedtmp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_feedcomp_use2_ix` (`userid`),
  ADD KEY `mdlfx_feedcomp_fee2_ix` (`feedback`);

--
-- Indexes for table `mdlfx_feedback_item`
--
ALTER TABLE `mdlfx_feedback_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_feeditem_fee_ix` (`feedback`),
  ADD KEY `mdlfx_feeditem_tem_ix` (`template`);

--
-- Indexes for table `mdlfx_feedback_sitecourse_map`
--
ALTER TABLE `mdlfx_feedback_sitecourse_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_feedsitemap_cou_ix` (`courseid`),
  ADD KEY `mdlfx_feedsitemap_fee_ix` (`feedbackid`);

--
-- Indexes for table `mdlfx_feedback_template`
--
ALTER TABLE `mdlfx_feedback_template`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_feedtemp_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_feedback_value`
--
ALTER TABLE `mdlfx_feedback_value`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_feedvalu_comitecou_uix` (`completed`,`item`,`course_id`),
  ADD KEY `mdlfx_feedvalu_cou_ix` (`course_id`),
  ADD KEY `mdlfx_feedvalu_ite_ix` (`item`);

--
-- Indexes for table `mdlfx_feedback_valuetmp`
--
ALTER TABLE `mdlfx_feedback_valuetmp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_feedvalu_comitecou2_uix` (`completed`,`item`,`course_id`),
  ADD KEY `mdlfx_feedvalu_cou2_ix` (`course_id`),
  ADD KEY `mdlfx_feedvalu_ite2_ix` (`item`);

--
-- Indexes for table `mdlfx_files`
--
ALTER TABLE `mdlfx_files`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_file_pat_uix` (`pathnamehash`),
  ADD KEY `mdlfx_file_comfilconite_ix` (`component`,`filearea`,`contextid`,`itemid`),
  ADD KEY `mdlfx_file_con_ix` (`contenthash`),
  ADD KEY `mdlfx_file_con2_ix` (`contextid`),
  ADD KEY `mdlfx_file_use_ix` (`userid`),
  ADD KEY `mdlfx_file_ref_ix` (`referencefileid`);

--
-- Indexes for table `mdlfx_files_reference`
--
ALTER TABLE `mdlfx_files_reference`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_filerefe_refrep_uix` (`referencehash`,`repositoryid`),
  ADD KEY `mdlfx_filerefe_rep_ix` (`repositoryid`);

--
-- Indexes for table `mdlfx_file_conversion`
--
ALTER TABLE `mdlfx_file_conversion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_fileconv_sou_ix` (`sourcefileid`),
  ADD KEY `mdlfx_fileconv_des_ix` (`destfileid`);

--
-- Indexes for table `mdlfx_filter_active`
--
ALTER TABLE `mdlfx_filter_active`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_filtacti_confil_uix` (`contextid`,`filter`),
  ADD KEY `mdlfx_filtacti_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_filter_config`
--
ALTER TABLE `mdlfx_filter_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_filtconf_confilnam_uix` (`contextid`,`filter`,`name`),
  ADD KEY `mdlfx_filtconf_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_folder`
--
ALTER TABLE `mdlfx_folder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_fold_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_forum`
--
ALTER TABLE `mdlfx_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_foru_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_forum_digests`
--
ALTER TABLE `mdlfx_forum_digests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_forudige_forusemai_uix` (`forum`,`userid`,`maildigest`),
  ADD KEY `mdlfx_forudige_use_ix` (`userid`),
  ADD KEY `mdlfx_forudige_for_ix` (`forum`);

--
-- Indexes for table `mdlfx_forum_discussions`
--
ALTER TABLE `mdlfx_forum_discussions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_forudisc_use_ix` (`userid`),
  ADD KEY `mdlfx_forudisc_cou_ix` (`course`),
  ADD KEY `mdlfx_forudisc_for_ix` (`forum`);

--
-- Indexes for table `mdlfx_forum_discussion_subs`
--
ALTER TABLE `mdlfx_forum_discussion_subs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_forudiscsubs_usedis_uix` (`userid`,`discussion`),
  ADD KEY `mdlfx_forudiscsubs_for_ix` (`forum`),
  ADD KEY `mdlfx_forudiscsubs_use_ix` (`userid`),
  ADD KEY `mdlfx_forudiscsubs_dis_ix` (`discussion`);

--
-- Indexes for table `mdlfx_forum_grades`
--
ALTER TABLE `mdlfx_forum_grades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_forugrad_foriteuse_uix` (`forum`,`itemnumber`,`userid`),
  ADD KEY `mdlfx_forugrad_use_ix` (`userid`),
  ADD KEY `mdlfx_forugrad_for_ix` (`forum`);

--
-- Indexes for table `mdlfx_forum_posts`
--
ALTER TABLE `mdlfx_forum_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_forupost_use_ix` (`userid`),
  ADD KEY `mdlfx_forupost_cre_ix` (`created`),
  ADD KEY `mdlfx_forupost_mai_ix` (`mailed`),
  ADD KEY `mdlfx_forupost_dis_ix` (`discussion`),
  ADD KEY `mdlfx_forupost_par_ix` (`parent`);

--
-- Indexes for table `mdlfx_forum_queue`
--
ALTER TABLE `mdlfx_forum_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_foruqueu_use_ix` (`userid`),
  ADD KEY `mdlfx_foruqueu_dis_ix` (`discussionid`),
  ADD KEY `mdlfx_foruqueu_pos_ix` (`postid`);

--
-- Indexes for table `mdlfx_forum_read`
--
ALTER TABLE `mdlfx_forum_read`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_foruread_usefor_ix` (`userid`,`forumid`),
  ADD KEY `mdlfx_foruread_usedis_ix` (`userid`,`discussionid`),
  ADD KEY `mdlfx_foruread_posuse_ix` (`postid`,`userid`);

--
-- Indexes for table `mdlfx_forum_subscriptions`
--
ALTER TABLE `mdlfx_forum_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_forusubs_usefor_uix` (`userid`,`forum`),
  ADD KEY `mdlfx_forusubs_use_ix` (`userid`),
  ADD KEY `mdlfx_forusubs_for_ix` (`forum`);

--
-- Indexes for table `mdlfx_forum_track_prefs`
--
ALTER TABLE `mdlfx_forum_track_prefs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_forutracpref_usefor_ix` (`userid`,`forumid`);

--
-- Indexes for table `mdlfx_glossary`
--
ALTER TABLE `mdlfx_glossary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_glos_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_glossary_alias`
--
ALTER TABLE `mdlfx_glossary_alias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_glosalia_ent_ix` (`entryid`);

--
-- Indexes for table `mdlfx_glossary_categories`
--
ALTER TABLE `mdlfx_glossary_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gloscate_glo_ix` (`glossaryid`);

--
-- Indexes for table `mdlfx_glossary_entries`
--
ALTER TABLE `mdlfx_glossary_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_glosentr_use_ix` (`userid`),
  ADD KEY `mdlfx_glosentr_con_ix` (`concept`),
  ADD KEY `mdlfx_glosentr_glo_ix` (`glossaryid`);

--
-- Indexes for table `mdlfx_glossary_entries_categories`
--
ALTER TABLE `mdlfx_glossary_entries_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_glosentrcate_cat_ix` (`categoryid`),
  ADD KEY `mdlfx_glosentrcate_ent_ix` (`entryid`);

--
-- Indexes for table `mdlfx_glossary_formats`
--
ALTER TABLE `mdlfx_glossary_formats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_grade_categories`
--
ALTER TABLE `mdlfx_grade_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradcate_cou_ix` (`courseid`),
  ADD KEY `mdlfx_gradcate_par_ix` (`parent`);

--
-- Indexes for table `mdlfx_grade_categories_history`
--
ALTER TABLE `mdlfx_grade_categories_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradcatehist_act_ix` (`action`),
  ADD KEY `mdlfx_gradcatehist_tim_ix` (`timemodified`),
  ADD KEY `mdlfx_gradcatehist_old_ix` (`oldid`),
  ADD KEY `mdlfx_gradcatehist_cou_ix` (`courseid`),
  ADD KEY `mdlfx_gradcatehist_par_ix` (`parent`),
  ADD KEY `mdlfx_gradcatehist_log_ix` (`loggeduser`);

--
-- Indexes for table `mdlfx_grade_grades`
--
ALTER TABLE `mdlfx_grade_grades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_gradgrad_useite_uix` (`userid`,`itemid`),
  ADD KEY `mdlfx_gradgrad_locloc_ix` (`locked`,`locktime`),
  ADD KEY `mdlfx_gradgrad_ite_ix` (`itemid`),
  ADD KEY `mdlfx_gradgrad_use_ix` (`userid`),
  ADD KEY `mdlfx_gradgrad_raw_ix` (`rawscaleid`),
  ADD KEY `mdlfx_gradgrad_use2_ix` (`usermodified`);

--
-- Indexes for table `mdlfx_grade_grades_history`
--
ALTER TABLE `mdlfx_grade_grades_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradgradhist_act_ix` (`action`),
  ADD KEY `mdlfx_gradgradhist_tim_ix` (`timemodified`),
  ADD KEY `mdlfx_gradgradhist_useiteti_ix` (`userid`,`itemid`,`timemodified`),
  ADD KEY `mdlfx_gradgradhist_old_ix` (`oldid`),
  ADD KEY `mdlfx_gradgradhist_ite_ix` (`itemid`),
  ADD KEY `mdlfx_gradgradhist_use_ix` (`userid`),
  ADD KEY `mdlfx_gradgradhist_raw_ix` (`rawscaleid`),
  ADD KEY `mdlfx_gradgradhist_use2_ix` (`usermodified`),
  ADD KEY `mdlfx_gradgradhist_log_ix` (`loggeduser`);

--
-- Indexes for table `mdlfx_grade_import_newitem`
--
ALTER TABLE `mdlfx_grade_import_newitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradimponewi_imp_ix` (`importer`);

--
-- Indexes for table `mdlfx_grade_import_values`
--
ALTER TABLE `mdlfx_grade_import_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradimpovalu_ite_ix` (`itemid`),
  ADD KEY `mdlfx_gradimpovalu_new_ix` (`newgradeitem`),
  ADD KEY `mdlfx_gradimpovalu_imp_ix` (`importer`);

--
-- Indexes for table `mdlfx_grade_items`
--
ALTER TABLE `mdlfx_grade_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_graditem_locloc_ix` (`locked`,`locktime`),
  ADD KEY `mdlfx_graditem_itenee_ix` (`itemtype`,`needsupdate`),
  ADD KEY `mdlfx_graditem_gra_ix` (`gradetype`),
  ADD KEY `mdlfx_graditem_idncou_ix` (`idnumber`,`courseid`),
  ADD KEY `mdlfx_graditem_cou_ix` (`courseid`),
  ADD KEY `mdlfx_graditem_cat_ix` (`categoryid`),
  ADD KEY `mdlfx_graditem_sca_ix` (`scaleid`),
  ADD KEY `mdlfx_graditem_out_ix` (`outcomeid`);

--
-- Indexes for table `mdlfx_grade_items_history`
--
ALTER TABLE `mdlfx_grade_items_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_graditemhist_act_ix` (`action`),
  ADD KEY `mdlfx_graditemhist_tim_ix` (`timemodified`),
  ADD KEY `mdlfx_graditemhist_old_ix` (`oldid`),
  ADD KEY `mdlfx_graditemhist_cou_ix` (`courseid`),
  ADD KEY `mdlfx_graditemhist_cat_ix` (`categoryid`),
  ADD KEY `mdlfx_graditemhist_sca_ix` (`scaleid`),
  ADD KEY `mdlfx_graditemhist_out_ix` (`outcomeid`),
  ADD KEY `mdlfx_graditemhist_log_ix` (`loggeduser`);

--
-- Indexes for table `mdlfx_grade_letters`
--
ALTER TABLE `mdlfx_grade_letters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_gradlett_conlowlet_uix` (`contextid`,`lowerboundary`,`letter`);

--
-- Indexes for table `mdlfx_grade_outcomes`
--
ALTER TABLE `mdlfx_grade_outcomes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_gradoutc_cousho_uix` (`courseid`,`shortname`),
  ADD KEY `mdlfx_gradoutc_cou_ix` (`courseid`),
  ADD KEY `mdlfx_gradoutc_sca_ix` (`scaleid`),
  ADD KEY `mdlfx_gradoutc_use_ix` (`usermodified`);

--
-- Indexes for table `mdlfx_grade_outcomes_courses`
--
ALTER TABLE `mdlfx_grade_outcomes_courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_gradoutccour_couout_uix` (`courseid`,`outcomeid`),
  ADD KEY `mdlfx_gradoutccour_cou_ix` (`courseid`),
  ADD KEY `mdlfx_gradoutccour_out_ix` (`outcomeid`);

--
-- Indexes for table `mdlfx_grade_outcomes_history`
--
ALTER TABLE `mdlfx_grade_outcomes_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradoutchist_act_ix` (`action`),
  ADD KEY `mdlfx_gradoutchist_tim_ix` (`timemodified`),
  ADD KEY `mdlfx_gradoutchist_old_ix` (`oldid`),
  ADD KEY `mdlfx_gradoutchist_cou_ix` (`courseid`),
  ADD KEY `mdlfx_gradoutchist_sca_ix` (`scaleid`),
  ADD KEY `mdlfx_gradoutchist_log_ix` (`loggeduser`);

--
-- Indexes for table `mdlfx_grade_settings`
--
ALTER TABLE `mdlfx_grade_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_gradsett_counam_uix` (`courseid`,`name`),
  ADD KEY `mdlfx_gradsett_cou_ix` (`courseid`);

--
-- Indexes for table `mdlfx_gradingform_guide_comments`
--
ALTER TABLE `mdlfx_gradingform_guide_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradguidcomm_def_ix` (`definitionid`);

--
-- Indexes for table `mdlfx_gradingform_guide_criteria`
--
ALTER TABLE `mdlfx_gradingform_guide_criteria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradguidcrit_def_ix` (`definitionid`);

--
-- Indexes for table `mdlfx_gradingform_guide_fillings`
--
ALTER TABLE `mdlfx_gradingform_guide_fillings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_gradguidfill_inscri_uix` (`instanceid`,`criterionid`),
  ADD KEY `mdlfx_gradguidfill_ins_ix` (`instanceid`),
  ADD KEY `mdlfx_gradguidfill_cri_ix` (`criterionid`);

--
-- Indexes for table `mdlfx_gradingform_rubric_criteria`
--
ALTER TABLE `mdlfx_gradingform_rubric_criteria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradrubrcrit_def_ix` (`definitionid`);

--
-- Indexes for table `mdlfx_gradingform_rubric_fillings`
--
ALTER TABLE `mdlfx_gradingform_rubric_fillings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_gradrubrfill_inscri_uix` (`instanceid`,`criterionid`),
  ADD KEY `mdlfx_gradrubrfill_lev_ix` (`levelid`),
  ADD KEY `mdlfx_gradrubrfill_ins_ix` (`instanceid`),
  ADD KEY `mdlfx_gradrubrfill_cri_ix` (`criterionid`);

--
-- Indexes for table `mdlfx_gradingform_rubric_levels`
--
ALTER TABLE `mdlfx_gradingform_rubric_levels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradrubrleve_cri_ix` (`criterionid`);

--
-- Indexes for table `mdlfx_grading_areas`
--
ALTER TABLE `mdlfx_grading_areas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_gradarea_concomare_uix` (`contextid`,`component`,`areaname`),
  ADD KEY `mdlfx_gradarea_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_grading_definitions`
--
ALTER TABLE `mdlfx_grading_definitions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_graddefi_aremet_uix` (`areaid`,`method`),
  ADD KEY `mdlfx_graddefi_are_ix` (`areaid`),
  ADD KEY `mdlfx_graddefi_use_ix` (`usermodified`),
  ADD KEY `mdlfx_graddefi_use2_ix` (`usercreated`);

--
-- Indexes for table `mdlfx_grading_instances`
--
ALTER TABLE `mdlfx_grading_instances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_gradinst_def_ix` (`definitionid`),
  ADD KEY `mdlfx_gradinst_rat_ix` (`raterid`);

--
-- Indexes for table `mdlfx_groupings`
--
ALTER TABLE `mdlfx_groupings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_grou_idn2_ix` (`idnumber`),
  ADD KEY `mdlfx_grou_cou2_ix` (`courseid`);

--
-- Indexes for table `mdlfx_groupings_groups`
--
ALTER TABLE `mdlfx_groupings_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_grougrou_gro_ix` (`groupingid`),
  ADD KEY `mdlfx_grougrou_gro2_ix` (`groupid`);

--
-- Indexes for table `mdlfx_groups`
--
ALTER TABLE `mdlfx_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_grou_idn_ix` (`idnumber`),
  ADD KEY `mdlfx_grou_cou_ix` (`courseid`);

--
-- Indexes for table `mdlfx_groups_members`
--
ALTER TABLE `mdlfx_groups_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_groumemb_usegro_uix` (`userid`,`groupid`),
  ADD KEY `mdlfx_groumemb_gro_ix` (`groupid`),
  ADD KEY `mdlfx_groumemb_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_h5p`
--
ALTER TABLE `mdlfx_h5p`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_h5p_mai_ix` (`mainlibraryid`);

--
-- Indexes for table `mdlfx_h5p_contents_libraries`
--
ALTER TABLE `mdlfx_h5p_contents_libraries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_h5pcontlibr_h5p_ix` (`h5pid`),
  ADD KEY `mdlfx_h5pcontlibr_lib_ix` (`libraryid`);

--
-- Indexes for table `mdlfx_h5p_libraries`
--
ALTER TABLE `mdlfx_h5p_libraries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_h5plibr_macmajminpatr_ix` (`machinename`,`majorversion`,`minorversion`,`patchversion`,`runnable`);

--
-- Indexes for table `mdlfx_h5p_libraries_cachedassets`
--
ALTER TABLE `mdlfx_h5p_libraries_cachedassets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_h5plibrcach_lib_ix` (`libraryid`);

--
-- Indexes for table `mdlfx_h5p_library_dependencies`
--
ALTER TABLE `mdlfx_h5p_library_dependencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_h5plibrdepe_lib_ix` (`libraryid`),
  ADD KEY `mdlfx_h5plibrdepe_req_ix` (`requiredlibraryid`);

--
-- Indexes for table `mdlfx_imscp`
--
ALTER TABLE `mdlfx_imscp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_imsc_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_label`
--
ALTER TABLE `mdlfx_label`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_labe_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_lesson`
--
ALTER TABLE `mdlfx_lesson`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_less_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_lesson_answers`
--
ALTER TABLE `mdlfx_lesson_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_lessansw_les_ix` (`lessonid`),
  ADD KEY `mdlfx_lessansw_pag_ix` (`pageid`);

--
-- Indexes for table `mdlfx_lesson_attempts`
--
ALTER TABLE `mdlfx_lesson_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_lessatte_use_ix` (`userid`),
  ADD KEY `mdlfx_lessatte_les_ix` (`lessonid`),
  ADD KEY `mdlfx_lessatte_pag_ix` (`pageid`),
  ADD KEY `mdlfx_lessatte_ans_ix` (`answerid`);

--
-- Indexes for table `mdlfx_lesson_branch`
--
ALTER TABLE `mdlfx_lesson_branch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_lessbran_use_ix` (`userid`),
  ADD KEY `mdlfx_lessbran_les_ix` (`lessonid`),
  ADD KEY `mdlfx_lessbran_pag_ix` (`pageid`);

--
-- Indexes for table `mdlfx_lesson_grades`
--
ALTER TABLE `mdlfx_lesson_grades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_lessgrad_use_ix` (`userid`),
  ADD KEY `mdlfx_lessgrad_les_ix` (`lessonid`);

--
-- Indexes for table `mdlfx_lesson_overrides`
--
ALTER TABLE `mdlfx_lesson_overrides`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_lessover_les_ix` (`lessonid`),
  ADD KEY `mdlfx_lessover_gro_ix` (`groupid`),
  ADD KEY `mdlfx_lessover_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_lesson_pages`
--
ALTER TABLE `mdlfx_lesson_pages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_lesspage_les_ix` (`lessonid`);

--
-- Indexes for table `mdlfx_lesson_timer`
--
ALTER TABLE `mdlfx_lesson_timer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_lesstime_use_ix` (`userid`),
  ADD KEY `mdlfx_lesstime_les_ix` (`lessonid`);

--
-- Indexes for table `mdlfx_license`
--
ALTER TABLE `mdlfx_license`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_lock_db`
--
ALTER TABLE `mdlfx_lock_db`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_lockdb_res_uix` (`resourcekey`),
  ADD KEY `mdlfx_lockdb_exp_ix` (`expires`),
  ADD KEY `mdlfx_lockdb_own_ix` (`owner`);

--
-- Indexes for table `mdlfx_log`
--
ALTER TABLE `mdlfx_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_log_coumodact_ix` (`course`,`module`,`action`),
  ADD KEY `mdlfx_log_tim_ix` (`time`),
  ADD KEY `mdlfx_log_act_ix` (`action`),
  ADD KEY `mdlfx_log_usecou_ix` (`userid`,`course`),
  ADD KEY `mdlfx_log_cmi_ix` (`cmid`);

--
-- Indexes for table `mdlfx_logstore_standard_log`
--
ALTER TABLE `mdlfx_logstore_standard_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_logsstanlog_tim_ix` (`timecreated`),
  ADD KEY `mdlfx_logsstanlog_couanotim_ix` (`courseid`,`anonymous`,`timecreated`),
  ADD KEY `mdlfx_logsstanlog_useconcon_ix` (`userid`,`contextlevel`,`contextinstanceid`,`crud`,`edulevel`,`timecreated`),
  ADD KEY `mdlfx_logsstanlog_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_log_display`
--
ALTER TABLE `mdlfx_log_display`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_logdisp_modact_uix` (`module`,`action`);

--
-- Indexes for table `mdlfx_log_queries`
--
ALTER TABLE `mdlfx_log_queries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_lti`
--
ALTER TABLE `mdlfx_lti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_lti_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_ltiservice_gradebookservices`
--
ALTER TABLE `mdlfx_ltiservice_gradebookservices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_ltisgrad_lti_ix` (`ltilinkid`),
  ADD KEY `mdlfx_ltisgrad_gracou_ix` (`gradeitemid`,`courseid`);

--
-- Indexes for table `mdlfx_lti_access_tokens`
--
ALTER TABLE `mdlfx_lti_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_ltiaccetoke_tok_uix` (`token`),
  ADD KEY `mdlfx_ltiaccetoke_typ_ix` (`typeid`);

--
-- Indexes for table `mdlfx_lti_submission`
--
ALTER TABLE `mdlfx_lti_submission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_ltisubm_lti_ix` (`ltiid`);

--
-- Indexes for table `mdlfx_lti_tool_proxies`
--
ALTER TABLE `mdlfx_lti_tool_proxies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_ltitoolprox_gui_uix` (`guid`);

--
-- Indexes for table `mdlfx_lti_tool_settings`
--
ALTER TABLE `mdlfx_lti_tool_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_ltitoolsett_too_ix` (`toolproxyid`),
  ADD KEY `mdlfx_ltitoolsett_typ_ix` (`typeid`),
  ADD KEY `mdlfx_ltitoolsett_cou_ix` (`course`),
  ADD KEY `mdlfx_ltitoolsett_cou2_ix` (`coursemoduleid`);

--
-- Indexes for table `mdlfx_lti_types`
--
ALTER TABLE `mdlfx_lti_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_ltitype_cli_uix` (`clientid`),
  ADD KEY `mdlfx_ltitype_cou_ix` (`course`),
  ADD KEY `mdlfx_ltitype_too_ix` (`tooldomain`);

--
-- Indexes for table `mdlfx_lti_types_config`
--
ALTER TABLE `mdlfx_lti_types_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_ltitypeconf_typ_ix` (`typeid`);

--
-- Indexes for table `mdlfx_message`
--
ALTER TABLE `mdlfx_message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_mess_useusetimtim_ix` (`useridfrom`,`useridto`,`timeuserfromdeleted`,`timeusertodeleted`),
  ADD KEY `mdlfx_mess_usetimnot_ix` (`useridfrom`,`timeuserfromdeleted`,`notification`),
  ADD KEY `mdlfx_mess_usetimnot2_ix` (`useridto`,`timeusertodeleted`,`notification`);

--
-- Indexes for table `mdlfx_messageinbound_datakeys`
--
ALTER TABLE `mdlfx_messageinbound_datakeys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messdata_handat_uix` (`handler`,`datavalue`),
  ADD KEY `mdlfx_messdata_han_ix` (`handler`);

--
-- Indexes for table `mdlfx_messageinbound_handlers`
--
ALTER TABLE `mdlfx_messageinbound_handlers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messhand_cla_uix` (`classname`);

--
-- Indexes for table `mdlfx_messageinbound_messagelist`
--
ALTER TABLE `mdlfx_messageinbound_messagelist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_messmess_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_messages`
--
ALTER TABLE `mdlfx_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_mess_contim_ix` (`conversationid`,`timecreated`),
  ADD KEY `mdlfx_mess_use_ix` (`useridfrom`),
  ADD KEY `mdlfx_mess_con_ix` (`conversationid`);

--
-- Indexes for table `mdlfx_message_airnotifier_devices`
--
ALTER TABLE `mdlfx_message_airnotifier_devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messairndevi_use_uix` (`userdeviceid`);

--
-- Indexes for table `mdlfx_message_contacts`
--
ALTER TABLE `mdlfx_message_contacts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messcont_usecon_uix` (`userid`,`contactid`),
  ADD KEY `mdlfx_messcont_use_ix` (`userid`),
  ADD KEY `mdlfx_messcont_con_ix` (`contactid`);

--
-- Indexes for table `mdlfx_message_contact_requests`
--
ALTER TABLE `mdlfx_message_contact_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messcontrequ_usereq_uix` (`userid`,`requesteduserid`),
  ADD KEY `mdlfx_messcontrequ_use_ix` (`userid`),
  ADD KEY `mdlfx_messcontrequ_req_ix` (`requesteduserid`);

--
-- Indexes for table `mdlfx_message_conversations`
--
ALTER TABLE `mdlfx_message_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_messconv_typ_ix` (`type`),
  ADD KEY `mdlfx_messconv_con_ix` (`convhash`),
  ADD KEY `mdlfx_messconv_comiteitecon_ix` (`component`,`itemtype`,`itemid`,`contextid`),
  ADD KEY `mdlfx_messconv_con2_ix` (`contextid`);

--
-- Indexes for table `mdlfx_message_conversation_actions`
--
ALTER TABLE `mdlfx_message_conversation_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_messconvacti_use_ix` (`userid`),
  ADD KEY `mdlfx_messconvacti_con_ix` (`conversationid`);

--
-- Indexes for table `mdlfx_message_conversation_members`
--
ALTER TABLE `mdlfx_message_conversation_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_messconvmemb_con_ix` (`conversationid`),
  ADD KEY `mdlfx_messconvmemb_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_message_email_messages`
--
ALTER TABLE `mdlfx_message_email_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_messemaimess_use_ix` (`useridto`),
  ADD KEY `mdlfx_messemaimess_con_ix` (`conversationid`),
  ADD KEY `mdlfx_messemaimess_mes_ix` (`messageid`);

--
-- Indexes for table `mdlfx_message_popup`
--
ALTER TABLE `mdlfx_message_popup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messpopu_mesisr_uix` (`messageid`,`isread`),
  ADD KEY `mdlfx_messpopu_isr_ix` (`isread`);

--
-- Indexes for table `mdlfx_message_popup_notifications`
--
ALTER TABLE `mdlfx_message_popup_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_messpopunoti_not_ix` (`notificationid`);

--
-- Indexes for table `mdlfx_message_processors`
--
ALTER TABLE `mdlfx_message_processors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_message_providers`
--
ALTER TABLE `mdlfx_message_providers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messprov_comnam_uix` (`component`,`name`);

--
-- Indexes for table `mdlfx_message_read`
--
ALTER TABLE `mdlfx_message_read`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_messread_useusetimtim_ix` (`useridfrom`,`useridto`,`timeuserfromdeleted`,`timeusertodeleted`),
  ADD KEY `mdlfx_messread_nottim_ix` (`notification`,`timeread`),
  ADD KEY `mdlfx_messread_usetimnot_ix` (`useridfrom`,`timeuserfromdeleted`,`notification`),
  ADD KEY `mdlfx_messread_usetimnot2_ix` (`useridto`,`timeusertodeleted`,`notification`);

--
-- Indexes for table `mdlfx_message_users_blocked`
--
ALTER TABLE `mdlfx_message_users_blocked`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messuserbloc_useblo_uix` (`userid`,`blockeduserid`),
  ADD KEY `mdlfx_messuserbloc_use_ix` (`userid`),
  ADD KEY `mdlfx_messuserbloc_blo_ix` (`blockeduserid`);

--
-- Indexes for table `mdlfx_message_user_actions`
--
ALTER TABLE `mdlfx_message_user_actions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_messuseracti_usemesa_uix` (`userid`,`messageid`,`action`),
  ADD KEY `mdlfx_messuseracti_use_ix` (`userid`),
  ADD KEY `mdlfx_messuseracti_mes_ix` (`messageid`);

--
-- Indexes for table `mdlfx_mnetservice_enrol_courses`
--
ALTER TABLE `mdlfx_mnetservice_enrol_courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_mnetenrocour_hosrem_uix` (`hostid`,`remoteid`);

--
-- Indexes for table `mdlfx_mnetservice_enrol_enrolments`
--
ALTER TABLE `mdlfx_mnetservice_enrol_enrolments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_mnetenroenro_use_ix` (`userid`),
  ADD KEY `mdlfx_mnetenroenro_hos_ix` (`hostid`);

--
-- Indexes for table `mdlfx_mnet_application`
--
ALTER TABLE `mdlfx_mnet_application`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_mnet_host`
--
ALTER TABLE `mdlfx_mnet_host`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_mnethost_app_ix` (`applicationid`);

--
-- Indexes for table `mdlfx_mnet_host2service`
--
ALTER TABLE `mdlfx_mnet_host2service`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_mnethost_hosser_uix` (`hostid`,`serviceid`);

--
-- Indexes for table `mdlfx_mnet_log`
--
ALTER TABLE `mdlfx_mnet_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_mnetlog_hosusecou_ix` (`hostid`,`userid`,`course`);

--
-- Indexes for table `mdlfx_mnet_remote_rpc`
--
ALTER TABLE `mdlfx_mnet_remote_rpc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_mnet_remote_service2rpc`
--
ALTER TABLE `mdlfx_mnet_remote_service2rpc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_mnetremoserv_rpcser_uix` (`rpcid`,`serviceid`);

--
-- Indexes for table `mdlfx_mnet_rpc`
--
ALTER TABLE `mdlfx_mnet_rpc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_mnetrpc_enaxml_ix` (`enabled`,`xmlrpcpath`);

--
-- Indexes for table `mdlfx_mnet_service`
--
ALTER TABLE `mdlfx_mnet_service`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_mnet_service2rpc`
--
ALTER TABLE `mdlfx_mnet_service2rpc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_mnetserv_rpcser_uix` (`rpcid`,`serviceid`);

--
-- Indexes for table `mdlfx_mnet_session`
--
ALTER TABLE `mdlfx_mnet_session`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_mnetsess_tok_uix` (`token`);

--
-- Indexes for table `mdlfx_mnet_sso_access_control`
--
ALTER TABLE `mdlfx_mnet_sso_access_control`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_mnetssoaccecont_mneu_uix` (`mnet_host_id`,`username`);

--
-- Indexes for table `mdlfx_modules`
--
ALTER TABLE `mdlfx_modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_modu_nam_ix` (`name`);

--
-- Indexes for table `mdlfx_my_pages`
--
ALTER TABLE `mdlfx_my_pages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_mypage_usepri_ix` (`userid`,`private`);

--
-- Indexes for table `mdlfx_notifications`
--
ALTER TABLE `mdlfx_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_noti_use_ix` (`useridfrom`),
  ADD KEY `mdlfx_noti_use2_ix` (`useridto`);

--
-- Indexes for table `mdlfx_oauth2_access_token`
--
ALTER TABLE `mdlfx_oauth2_access_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_oautaccetoke_iss_uix` (`issuerid`);

--
-- Indexes for table `mdlfx_oauth2_endpoint`
--
ALTER TABLE `mdlfx_oauth2_endpoint`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_oautendp_iss_ix` (`issuerid`);

--
-- Indexes for table `mdlfx_oauth2_issuer`
--
ALTER TABLE `mdlfx_oauth2_issuer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_oauth2_system_account`
--
ALTER TABLE `mdlfx_oauth2_system_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_oautsystacco_iss_uix` (`issuerid`);

--
-- Indexes for table `mdlfx_oauth2_user_field_mapping`
--
ALTER TABLE `mdlfx_oauth2_user_field_mapping`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_oautuserfielmapp_iss_uix` (`issuerid`,`internalfield`),
  ADD KEY `mdlfx_oautuserfielmapp_iss_ix` (`issuerid`);

--
-- Indexes for table `mdlfx_page`
--
ALTER TABLE `mdlfx_page`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_page_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_portfolio_instance`
--
ALTER TABLE `mdlfx_portfolio_instance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_portfolio_instance_config`
--
ALTER TABLE `mdlfx_portfolio_instance_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_portinstconf_nam_ix` (`name`),
  ADD KEY `mdlfx_portinstconf_ins_ix` (`instance`);

--
-- Indexes for table `mdlfx_portfolio_instance_user`
--
ALTER TABLE `mdlfx_portfolio_instance_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_portinstuser_ins_ix` (`instance`),
  ADD KEY `mdlfx_portinstuser_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_portfolio_log`
--
ALTER TABLE `mdlfx_portfolio_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_portlog_use_ix` (`userid`),
  ADD KEY `mdlfx_portlog_por_ix` (`portfolio`);

--
-- Indexes for table `mdlfx_portfolio_mahara_queue`
--
ALTER TABLE `mdlfx_portfolio_mahara_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_portmahaqueu_tok_ix` (`token`),
  ADD KEY `mdlfx_portmahaqueu_tra_ix` (`transferid`);

--
-- Indexes for table `mdlfx_portfolio_tempdata`
--
ALTER TABLE `mdlfx_portfolio_tempdata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_porttemp_use_ix` (`userid`),
  ADD KEY `mdlfx_porttemp_ins_ix` (`instance`);

--
-- Indexes for table `mdlfx_post`
--
ALTER TABLE `mdlfx_post`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_post_iduse_uix` (`id`,`userid`),
  ADD KEY `mdlfx_post_las_ix` (`lastmodified`),
  ADD KEY `mdlfx_post_mod_ix` (`module`),
  ADD KEY `mdlfx_post_sub_ix` (`subject`),
  ADD KEY `mdlfx_post_use_ix` (`usermodified`);

--
-- Indexes for table `mdlfx_profiling`
--
ALTER TABLE `mdlfx_profiling`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_prof_run_uix` (`runid`),
  ADD KEY `mdlfx_prof_urlrun_ix` (`url`,`runreference`),
  ADD KEY `mdlfx_prof_timrun_ix` (`timecreated`,`runreference`);

--
-- Indexes for table `mdlfx_qtype_ddimageortext`
--
ALTER TABLE `mdlfx_qtype_ddimageortext`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_qtypddim_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_ddimageortext_drags`
--
ALTER TABLE `mdlfx_qtype_ddimageortext_drags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_qtypddimdrag_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_ddimageortext_drops`
--
ALTER TABLE `mdlfx_qtype_ddimageortext_drops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_qtypddimdrop_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_ddmarker`
--
ALTER TABLE `mdlfx_qtype_ddmarker`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_qtypddma_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_ddmarker_drags`
--
ALTER TABLE `mdlfx_qtype_ddmarker_drags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_qtypddmadrag_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_ddmarker_drops`
--
ALTER TABLE `mdlfx_qtype_ddmarker_drops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_qtypddmadrop_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_essay_options`
--
ALTER TABLE `mdlfx_qtype_essay_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_qtypessaopti_que_uix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_match_options`
--
ALTER TABLE `mdlfx_qtype_match_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_qtypmatcopti_que_uix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_match_subquestions`
--
ALTER TABLE `mdlfx_qtype_match_subquestions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_qtypmatcsubq_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_multichoice_options`
--
ALTER TABLE `mdlfx_qtype_multichoice_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_qtypmultopti_que_uix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_randomsamatch_options`
--
ALTER TABLE `mdlfx_qtype_randomsamatch_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_qtyprandopti_que_uix` (`questionid`);

--
-- Indexes for table `mdlfx_qtype_shortanswer_options`
--
ALTER TABLE `mdlfx_qtype_shortanswer_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_qtypshoropti_que_uix` (`questionid`);

--
-- Indexes for table `mdlfx_question`
--
ALTER TABLE `mdlfx_question`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_ques_catidn_uix` (`category`,`idnumber`),
  ADD KEY `mdlfx_ques_qty_ix` (`qtype`),
  ADD KEY `mdlfx_ques_cat_ix` (`category`),
  ADD KEY `mdlfx_ques_par_ix` (`parent`),
  ADD KEY `mdlfx_ques_cre_ix` (`createdby`),
  ADD KEY `mdlfx_ques_mod_ix` (`modifiedby`);

--
-- Indexes for table `mdlfx_question_answers`
--
ALTER TABLE `mdlfx_question_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesansw_que_ix` (`question`);

--
-- Indexes for table `mdlfx_question_attempts`
--
ALTER TABLE `mdlfx_question_attempts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_quesatte_queslo_uix` (`questionusageid`,`slot`),
  ADD KEY `mdlfx_quesatte_beh_ix` (`behaviour`),
  ADD KEY `mdlfx_quesatte_que_ix` (`questionid`),
  ADD KEY `mdlfx_quesatte_que2_ix` (`questionusageid`);

--
-- Indexes for table `mdlfx_question_attempt_steps`
--
ALTER TABLE `mdlfx_question_attempt_steps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_quesattestep_queseq_uix` (`questionattemptid`,`sequencenumber`),
  ADD KEY `mdlfx_quesattestep_que_ix` (`questionattemptid`),
  ADD KEY `mdlfx_quesattestep_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_question_attempt_step_data`
--
ALTER TABLE `mdlfx_question_attempt_step_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesattestepdata_att_ix` (`attemptstepid`);

--
-- Indexes for table `mdlfx_question_calculated`
--
ALTER TABLE `mdlfx_question_calculated`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quescalc_ans_ix` (`answer`),
  ADD KEY `mdlfx_quescalc_que_ix` (`question`);

--
-- Indexes for table `mdlfx_question_calculated_options`
--
ALTER TABLE `mdlfx_question_calculated_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quescalcopti_que_ix` (`question`);

--
-- Indexes for table `mdlfx_question_categories`
--
ALTER TABLE `mdlfx_question_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_quescate_consta_uix` (`contextid`,`stamp`),
  ADD UNIQUE KEY `mdlfx_quescate_conidn_uix` (`contextid`,`idnumber`),
  ADD KEY `mdlfx_quescate_con_ix` (`contextid`),
  ADD KEY `mdlfx_quescate_par_ix` (`parent`);

--
-- Indexes for table `mdlfx_question_datasets`
--
ALTER TABLE `mdlfx_question_datasets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesdata_quedat_ix` (`question`,`datasetdefinition`),
  ADD KEY `mdlfx_quesdata_que_ix` (`question`),
  ADD KEY `mdlfx_quesdata_dat_ix` (`datasetdefinition`);

--
-- Indexes for table `mdlfx_question_dataset_definitions`
--
ALTER TABLE `mdlfx_question_dataset_definitions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesdatadefi_cat_ix` (`category`);

--
-- Indexes for table `mdlfx_question_dataset_items`
--
ALTER TABLE `mdlfx_question_dataset_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesdataitem_def_ix` (`definition`);

--
-- Indexes for table `mdlfx_question_ddwtos`
--
ALTER TABLE `mdlfx_question_ddwtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesddwt_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_question_gapselect`
--
ALTER TABLE `mdlfx_question_gapselect`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesgaps_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_question_hints`
--
ALTER TABLE `mdlfx_question_hints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_queshint_que_ix` (`questionid`);

--
-- Indexes for table `mdlfx_question_multianswer`
--
ALTER TABLE `mdlfx_question_multianswer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesmult_que_ix` (`question`);

--
-- Indexes for table `mdlfx_question_numerical`
--
ALTER TABLE `mdlfx_question_numerical`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesnume_ans_ix` (`answer`),
  ADD KEY `mdlfx_quesnume_que_ix` (`question`);

--
-- Indexes for table `mdlfx_question_numerical_options`
--
ALTER TABLE `mdlfx_question_numerical_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesnumeopti_que_ix` (`question`);

--
-- Indexes for table `mdlfx_question_numerical_units`
--
ALTER TABLE `mdlfx_question_numerical_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_quesnumeunit_queuni_uix` (`question`,`unit`),
  ADD KEY `mdlfx_quesnumeunit_que_ix` (`question`);

--
-- Indexes for table `mdlfx_question_response_analysis`
--
ALTER TABLE `mdlfx_question_response_analysis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_question_response_count`
--
ALTER TABLE `mdlfx_question_response_count`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesrespcoun_ana_ix` (`analysisid`);

--
-- Indexes for table `mdlfx_question_statistics`
--
ALTER TABLE `mdlfx_question_statistics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_question_truefalse`
--
ALTER TABLE `mdlfx_question_truefalse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_questrue_que_ix` (`question`);

--
-- Indexes for table `mdlfx_question_usages`
--
ALTER TABLE `mdlfx_question_usages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quesusag_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_quiz`
--
ALTER TABLE `mdlfx_quiz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quiz_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_quiz_attempts`
--
ALTER TABLE `mdlfx_quiz_attempts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_quizatte_quiuseatt_uix` (`quiz`,`userid`,`attempt`),
  ADD UNIQUE KEY `mdlfx_quizatte_uni_uix` (`uniqueid`),
  ADD KEY `mdlfx_quizatte_statim_ix` (`state`,`timecheckstate`),
  ADD KEY `mdlfx_quizatte_qui_ix` (`quiz`),
  ADD KEY `mdlfx_quizatte_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_quiz_feedback`
--
ALTER TABLE `mdlfx_quiz_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quizfeed_qui_ix` (`quizid`);

--
-- Indexes for table `mdlfx_quiz_grades`
--
ALTER TABLE `mdlfx_quiz_grades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quizgrad_use_ix` (`userid`),
  ADD KEY `mdlfx_quizgrad_qui_ix` (`quiz`);

--
-- Indexes for table `mdlfx_quiz_overrides`
--
ALTER TABLE `mdlfx_quiz_overrides`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quizover_qui_ix` (`quiz`),
  ADD KEY `mdlfx_quizover_gro_ix` (`groupid`),
  ADD KEY `mdlfx_quizover_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_quiz_overview_regrades`
--
ALTER TABLE `mdlfx_quiz_overview_regrades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quizoverregr_queslo_ix` (`questionusageid`,`slot`);

--
-- Indexes for table `mdlfx_quiz_reports`
--
ALTER TABLE `mdlfx_quiz_reports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_quizrepo_nam_uix` (`name`);

--
-- Indexes for table `mdlfx_quiz_sections`
--
ALTER TABLE `mdlfx_quiz_sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_quizsect_quifir_uix` (`quizid`,`firstslot`),
  ADD KEY `mdlfx_quizsect_qui_ix` (`quizid`);

--
-- Indexes for table `mdlfx_quiz_slots`
--
ALTER TABLE `mdlfx_quiz_slots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_quizslot_quislo_uix` (`quizid`,`slot`),
  ADD KEY `mdlfx_quizslot_qui_ix` (`quizid`),
  ADD KEY `mdlfx_quizslot_que_ix` (`questionid`),
  ADD KEY `mdlfx_quizslot_que2_ix` (`questioncategoryid`);

--
-- Indexes for table `mdlfx_quiz_slot_tags`
--
ALTER TABLE `mdlfx_quiz_slot_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_quizslottags_slo_ix` (`slotid`),
  ADD KEY `mdlfx_quizslottags_tag_ix` (`tagid`);

--
-- Indexes for table `mdlfx_quiz_statistics`
--
ALTER TABLE `mdlfx_quiz_statistics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_rating`
--
ALTER TABLE `mdlfx_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_rati_comratconite_ix` (`component`,`ratingarea`,`contextid`,`itemid`),
  ADD KEY `mdlfx_rati_con_ix` (`contextid`),
  ADD KEY `mdlfx_rati_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_registration_hubs`
--
ALTER TABLE `mdlfx_registration_hubs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_repository`
--
ALTER TABLE `mdlfx_repository`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_repository_instances`
--
ALTER TABLE `mdlfx_repository_instances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_repository_instance_config`
--
ALTER TABLE `mdlfx_repository_instance_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_repository_onedrive_access`
--
ALTER TABLE `mdlfx_repository_onedrive_access`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_repoonedacce_use_ix` (`usermodified`);

--
-- Indexes for table `mdlfx_resource`
--
ALTER TABLE `mdlfx_resource`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_reso_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_resource_old`
--
ALTER TABLE `mdlfx_resource_old`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_resoold_old_uix` (`oldid`),
  ADD KEY `mdlfx_resoold_cmi_ix` (`cmid`);

--
-- Indexes for table `mdlfx_role`
--
ALTER TABLE `mdlfx_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_role_sor_uix` (`sortorder`),
  ADD UNIQUE KEY `mdlfx_role_sho_uix` (`shortname`);

--
-- Indexes for table `mdlfx_role_allow_assign`
--
ALTER TABLE `mdlfx_role_allow_assign`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_rolealloassi_rolall_uix` (`roleid`,`allowassign`),
  ADD KEY `mdlfx_rolealloassi_rol_ix` (`roleid`),
  ADD KEY `mdlfx_rolealloassi_all_ix` (`allowassign`);

--
-- Indexes for table `mdlfx_role_allow_override`
--
ALTER TABLE `mdlfx_role_allow_override`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_rolealloover_rolall_uix` (`roleid`,`allowoverride`),
  ADD KEY `mdlfx_rolealloover_rol_ix` (`roleid`),
  ADD KEY `mdlfx_rolealloover_all_ix` (`allowoverride`);

--
-- Indexes for table `mdlfx_role_allow_switch`
--
ALTER TABLE `mdlfx_role_allow_switch`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_rolealloswit_rolall_uix` (`roleid`,`allowswitch`),
  ADD KEY `mdlfx_rolealloswit_rol_ix` (`roleid`),
  ADD KEY `mdlfx_rolealloswit_all_ix` (`allowswitch`);

--
-- Indexes for table `mdlfx_role_allow_view`
--
ALTER TABLE `mdlfx_role_allow_view`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_rolealloview_rolall_uix` (`roleid`,`allowview`),
  ADD KEY `mdlfx_rolealloview_rol_ix` (`roleid`),
  ADD KEY `mdlfx_rolealloview_all_ix` (`allowview`);

--
-- Indexes for table `mdlfx_role_assignments`
--
ALTER TABLE `mdlfx_role_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_roleassi_sor_ix` (`sortorder`),
  ADD KEY `mdlfx_roleassi_rolcon_ix` (`roleid`,`contextid`),
  ADD KEY `mdlfx_roleassi_useconrol_ix` (`userid`,`contextid`,`roleid`),
  ADD KEY `mdlfx_roleassi_comiteuse_ix` (`component`,`itemid`,`userid`),
  ADD KEY `mdlfx_roleassi_rol_ix` (`roleid`),
  ADD KEY `mdlfx_roleassi_con_ix` (`contextid`),
  ADD KEY `mdlfx_roleassi_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_role_capabilities`
--
ALTER TABLE `mdlfx_role_capabilities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_rolecapa_rolconcap_uix` (`roleid`,`contextid`,`capability`),
  ADD KEY `mdlfx_rolecapa_rol_ix` (`roleid`),
  ADD KEY `mdlfx_rolecapa_con_ix` (`contextid`),
  ADD KEY `mdlfx_rolecapa_mod_ix` (`modifierid`),
  ADD KEY `mdlfx_rolecapa_cap_ix` (`capability`);

--
-- Indexes for table `mdlfx_role_context_levels`
--
ALTER TABLE `mdlfx_role_context_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_rolecontleve_conrol_uix` (`contextlevel`,`roleid`),
  ADD KEY `mdlfx_rolecontleve_rol_ix` (`roleid`);

--
-- Indexes for table `mdlfx_role_names`
--
ALTER TABLE `mdlfx_role_names`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_rolename_rolcon_uix` (`roleid`,`contextid`),
  ADD KEY `mdlfx_rolename_rol_ix` (`roleid`),
  ADD KEY `mdlfx_rolename_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_scale`
--
ALTER TABLE `mdlfx_scale`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_scal_cou_ix` (`courseid`);

--
-- Indexes for table `mdlfx_scale_history`
--
ALTER TABLE `mdlfx_scale_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_scalhist_act_ix` (`action`),
  ADD KEY `mdlfx_scalhist_tim_ix` (`timemodified`),
  ADD KEY `mdlfx_scalhist_old_ix` (`oldid`),
  ADD KEY `mdlfx_scalhist_cou_ix` (`courseid`),
  ADD KEY `mdlfx_scalhist_log_ix` (`loggeduser`);

--
-- Indexes for table `mdlfx_scorm`
--
ALTER TABLE `mdlfx_scorm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_scor_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_scorm_aicc_session`
--
ALTER TABLE `mdlfx_scorm_aicc_session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_scoraiccsess_sco_ix` (`scormid`),
  ADD KEY `mdlfx_scoraiccsess_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_scorm_scoes`
--
ALTER TABLE `mdlfx_scorm_scoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_scorscoe_sco_ix` (`scorm`);

--
-- Indexes for table `mdlfx_scorm_scoes_data`
--
ALTER TABLE `mdlfx_scorm_scoes_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_scorscoedata_sco_ix` (`scoid`);

--
-- Indexes for table `mdlfx_scorm_scoes_track`
--
ALTER TABLE `mdlfx_scorm_scoes_track`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_scorscoetrac_usescos_uix` (`userid`,`scormid`,`scoid`,`attempt`,`element`),
  ADD KEY `mdlfx_scorscoetrac_use_ix` (`userid`),
  ADD KEY `mdlfx_scorscoetrac_sco_ix` (`scormid`),
  ADD KEY `mdlfx_scorscoetrac_sco2_ix` (`scoid`);

--
-- Indexes for table `mdlfx_scorm_seq_mapinfo`
--
ALTER TABLE `mdlfx_scorm_seq_mapinfo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_scorseqmapi_scoidobj_uix` (`scoid`,`id`,`objectiveid`),
  ADD KEY `mdlfx_scorseqmapi_sco_ix` (`scoid`),
  ADD KEY `mdlfx_scorseqmapi_obj_ix` (`objectiveid`);

--
-- Indexes for table `mdlfx_scorm_seq_objective`
--
ALTER TABLE `mdlfx_scorm_seq_objective`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_scorseqobje_scoid_uix` (`scoid`,`id`),
  ADD KEY `mdlfx_scorseqobje_sco_ix` (`scoid`);

--
-- Indexes for table `mdlfx_scorm_seq_rolluprule`
--
ALTER TABLE `mdlfx_scorm_seq_rolluprule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_scorseqroll_scoid_uix` (`scoid`,`id`),
  ADD KEY `mdlfx_scorseqroll_sco_ix` (`scoid`);

--
-- Indexes for table `mdlfx_scorm_seq_rolluprulecond`
--
ALTER TABLE `mdlfx_scorm_seq_rolluprulecond`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_scorseqroll_scorolid_uix` (`scoid`,`rollupruleid`,`id`),
  ADD KEY `mdlfx_scorseqroll_sco2_ix` (`scoid`),
  ADD KEY `mdlfx_scorseqroll_rol_ix` (`rollupruleid`);

--
-- Indexes for table `mdlfx_scorm_seq_rulecond`
--
ALTER TABLE `mdlfx_scorm_seq_rulecond`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_scorseqrule_idscorul_uix` (`id`,`scoid`,`ruleconditionsid`),
  ADD KEY `mdlfx_scorseqrule_sco2_ix` (`scoid`),
  ADD KEY `mdlfx_scorseqrule_rul_ix` (`ruleconditionsid`);

--
-- Indexes for table `mdlfx_scorm_seq_ruleconds`
--
ALTER TABLE `mdlfx_scorm_seq_ruleconds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_scorseqrule_scoid_uix` (`scoid`,`id`),
  ADD KEY `mdlfx_scorseqrule_sco_ix` (`scoid`);

--
-- Indexes for table `mdlfx_search_index_requests`
--
ALTER TABLE `mdlfx_search_index_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_searinderequ_indtim_ix` (`indexpriority`,`timerequested`),
  ADD KEY `mdlfx_searinderequ_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_search_simpledb_index`
--
ALTER TABLE `mdlfx_search_simpledb_index`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_searsimpinde_doc_uix` (`docid`),
  ADD KEY `mdlfx_searsimpinde_owncon_ix` (`owneruserid`,`contextid`);
ALTER TABLE `mdlfx_search_simpledb_index` ADD FULLTEXT KEY `mdlfx_search_simpledb_index_index` (`title`,`content`,`description1`,`description2`);

--
-- Indexes for table `mdlfx_sessions`
--
ALTER TABLE `mdlfx_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_sess_sid_uix` (`sid`),
  ADD KEY `mdlfx_sess_sta_ix` (`state`),
  ADD KEY `mdlfx_sess_tim_ix` (`timecreated`),
  ADD KEY `mdlfx_sess_tim2_ix` (`timemodified`),
  ADD KEY `mdlfx_sess_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_stats_daily`
--
ALTER TABLE `mdlfx_stats_daily`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_statdail_cou_ix` (`courseid`),
  ADD KEY `mdlfx_statdail_tim_ix` (`timeend`),
  ADD KEY `mdlfx_statdail_rol_ix` (`roleid`);

--
-- Indexes for table `mdlfx_stats_monthly`
--
ALTER TABLE `mdlfx_stats_monthly`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_statmont_cou_ix` (`courseid`),
  ADD KEY `mdlfx_statmont_tim_ix` (`timeend`),
  ADD KEY `mdlfx_statmont_rol_ix` (`roleid`);

--
-- Indexes for table `mdlfx_stats_user_daily`
--
ALTER TABLE `mdlfx_stats_user_daily`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_statuserdail_cou_ix` (`courseid`),
  ADD KEY `mdlfx_statuserdail_use_ix` (`userid`),
  ADD KEY `mdlfx_statuserdail_rol_ix` (`roleid`),
  ADD KEY `mdlfx_statuserdail_tim_ix` (`timeend`);

--
-- Indexes for table `mdlfx_stats_user_monthly`
--
ALTER TABLE `mdlfx_stats_user_monthly`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_statusermont_cou_ix` (`courseid`),
  ADD KEY `mdlfx_statusermont_use_ix` (`userid`),
  ADD KEY `mdlfx_statusermont_rol_ix` (`roleid`),
  ADD KEY `mdlfx_statusermont_tim_ix` (`timeend`);

--
-- Indexes for table `mdlfx_stats_user_weekly`
--
ALTER TABLE `mdlfx_stats_user_weekly`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_statuserweek_cou_ix` (`courseid`),
  ADD KEY `mdlfx_statuserweek_use_ix` (`userid`),
  ADD KEY `mdlfx_statuserweek_rol_ix` (`roleid`),
  ADD KEY `mdlfx_statuserweek_tim_ix` (`timeend`);

--
-- Indexes for table `mdlfx_stats_weekly`
--
ALTER TABLE `mdlfx_stats_weekly`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_statweek_cou_ix` (`courseid`),
  ADD KEY `mdlfx_statweek_tim_ix` (`timeend`),
  ADD KEY `mdlfx_statweek_rol_ix` (`roleid`);

--
-- Indexes for table `mdlfx_survey`
--
ALTER TABLE `mdlfx_survey`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_surv_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_survey_analysis`
--
ALTER TABLE `mdlfx_survey_analysis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_survanal_use_ix` (`userid`),
  ADD KEY `mdlfx_survanal_sur_ix` (`survey`);

--
-- Indexes for table `mdlfx_survey_answers`
--
ALTER TABLE `mdlfx_survey_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_survansw_use_ix` (`userid`),
  ADD KEY `mdlfx_survansw_sur_ix` (`survey`),
  ADD KEY `mdlfx_survansw_que_ix` (`question`);

--
-- Indexes for table `mdlfx_survey_questions`
--
ALTER TABLE `mdlfx_survey_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_tag`
--
ALTER TABLE `mdlfx_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_tag_tagnam_uix` (`tagcollid`,`name`),
  ADD KEY `mdlfx_tag_tagiss_ix` (`tagcollid`,`isstandard`),
  ADD KEY `mdlfx_tag_use_ix` (`userid`),
  ADD KEY `mdlfx_tag_tag_ix` (`tagcollid`);

--
-- Indexes for table `mdlfx_tag_area`
--
ALTER TABLE `mdlfx_tag_area`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_tagarea_comite_uix` (`component`,`itemtype`),
  ADD KEY `mdlfx_tagarea_tag_ix` (`tagcollid`);

--
-- Indexes for table `mdlfx_tag_coll`
--
ALTER TABLE `mdlfx_tag_coll`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_tag_correlation`
--
ALTER TABLE `mdlfx_tag_correlation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_tagcorr_tag_ix` (`tagid`);

--
-- Indexes for table `mdlfx_tag_instance`
--
ALTER TABLE `mdlfx_tag_instance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_taginst_comiteitecon_uix` (`component`,`itemtype`,`itemid`,`contextid`,`tiuserid`,`tagid`),
  ADD KEY `mdlfx_taginst_itecomtagcon_ix` (`itemtype`,`component`,`tagid`,`contextid`),
  ADD KEY `mdlfx_taginst_tag_ix` (`tagid`),
  ADD KEY `mdlfx_taginst_con_ix` (`contextid`);

--
-- Indexes for table `mdlfx_task_adhoc`
--
ALTER TABLE `mdlfx_task_adhoc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_taskadho_nex_ix` (`nextruntime`),
  ADD KEY `mdlfx_taskadho_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_task_log`
--
ALTER TABLE `mdlfx_task_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_tasklog_cla_ix` (`classname`),
  ADD KEY `mdlfx_tasklog_tim_ix` (`timestart`);

--
-- Indexes for table `mdlfx_task_scheduled`
--
ALTER TABLE `mdlfx_task_scheduled`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_tasksche_cla_uix` (`classname`);

--
-- Indexes for table `mdlfx_tool_cohortroles`
--
ALTER TABLE `mdlfx_tool_cohortroles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_toolcoho_cohroluse_uix` (`cohortid`,`roleid`,`userid`);

--
-- Indexes for table `mdlfx_tool_customlang`
--
ALTER TABLE `mdlfx_tool_customlang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_toolcust_lancomstr_uix` (`lang`,`componentid`,`stringid`),
  ADD KEY `mdlfx_toolcust_com_ix` (`componentid`);

--
-- Indexes for table `mdlfx_tool_customlang_components`
--
ALTER TABLE `mdlfx_tool_customlang_components`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_tool_dataprivacy_category`
--
ALTER TABLE `mdlfx_tool_dataprivacy_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_tool_dataprivacy_ctxexpired`
--
ALTER TABLE `mdlfx_tool_dataprivacy_ctxexpired`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_tooldatactxe_con_uix` (`contextid`);

--
-- Indexes for table `mdlfx_tool_dataprivacy_ctxinstance`
--
ALTER TABLE `mdlfx_tool_dataprivacy_ctxinstance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_tooldatactxi_con_uix` (`contextid`),
  ADD KEY `mdlfx_tooldatactxi_pur_ix` (`purposeid`),
  ADD KEY `mdlfx_tooldatactxi_cat_ix` (`categoryid`);

--
-- Indexes for table `mdlfx_tool_dataprivacy_ctxlevel`
--
ALTER TABLE `mdlfx_tool_dataprivacy_ctxlevel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_tooldatactxl_con_uix` (`contextlevel`),
  ADD KEY `mdlfx_tooldatactxl_cat_ix` (`categoryid`),
  ADD KEY `mdlfx_tooldatactxl_pur_ix` (`purposeid`);

--
-- Indexes for table `mdlfx_tool_dataprivacy_purpose`
--
ALTER TABLE `mdlfx_tool_dataprivacy_purpose`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_tool_dataprivacy_purposerole`
--
ALTER TABLE `mdlfx_tool_dataprivacy_purposerole`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_tooldatapurp_purrol_uix` (`purposeid`,`roleid`),
  ADD KEY `mdlfx_tooldatapurp_pur_ix` (`purposeid`),
  ADD KEY `mdlfx_tooldatapurp_rol_ix` (`roleid`);

--
-- Indexes for table `mdlfx_tool_dataprivacy_request`
--
ALTER TABLE `mdlfx_tool_dataprivacy_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_tooldatarequ_use_ix` (`userid`),
  ADD KEY `mdlfx_tooldatarequ_req_ix` (`requestedby`),
  ADD KEY `mdlfx_tooldatarequ_dpo_ix` (`dpo`),
  ADD KEY `mdlfx_tooldatarequ_use2_ix` (`usermodified`);

--
-- Indexes for table `mdlfx_tool_monitor_events`
--
ALTER TABLE `mdlfx_tool_monitor_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_tool_monitor_history`
--
ALTER TABLE `mdlfx_tool_monitor_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_toolmonihist_siduset_uix` (`sid`,`userid`,`timesent`),
  ADD KEY `mdlfx_toolmonihist_sid_ix` (`sid`);

--
-- Indexes for table `mdlfx_tool_monitor_rules`
--
ALTER TABLE `mdlfx_tool_monitor_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_toolmonirule_couuse_ix` (`courseid`,`userid`),
  ADD KEY `mdlfx_toolmonirule_eve_ix` (`eventname`);

--
-- Indexes for table `mdlfx_tool_monitor_subscriptions`
--
ALTER TABLE `mdlfx_tool_monitor_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_toolmonisubs_couuse_ix` (`courseid`,`userid`),
  ADD KEY `mdlfx_toolmonisubs_rul_ix` (`ruleid`);

--
-- Indexes for table `mdlfx_tool_policy`
--
ALTER TABLE `mdlfx_tool_policy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_toolpoli_cur_ix` (`currentversionid`);

--
-- Indexes for table `mdlfx_tool_policy_acceptances`
--
ALTER TABLE `mdlfx_tool_policy_acceptances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_toolpoliacce_poluse_uix` (`policyversionid`,`userid`),
  ADD KEY `mdlfx_toolpoliacce_pol_ix` (`policyversionid`),
  ADD KEY `mdlfx_toolpoliacce_use_ix` (`userid`),
  ADD KEY `mdlfx_toolpoliacce_use2_ix` (`usermodified`);

--
-- Indexes for table `mdlfx_tool_policy_versions`
--
ALTER TABLE `mdlfx_tool_policy_versions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_toolpolivers_use_ix` (`usermodified`),
  ADD KEY `mdlfx_toolpolivers_pol_ix` (`policyid`);

--
-- Indexes for table `mdlfx_tool_recyclebin_category`
--
ALTER TABLE `mdlfx_tool_recyclebin_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_toolrecycate_tim_ix` (`timecreated`),
  ADD KEY `mdlfx_toolrecycate_cat_ix` (`categoryid`);

--
-- Indexes for table `mdlfx_tool_recyclebin_course`
--
ALTER TABLE `mdlfx_tool_recyclebin_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_toolrecycour_tim_ix` (`timecreated`),
  ADD KEY `mdlfx_toolrecycour_cou_ix` (`courseid`);

--
-- Indexes for table `mdlfx_tool_usertours_steps`
--
ALTER TABLE `mdlfx_tool_usertours_steps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_tooluserstep_tousor_ix` (`tourid`,`sortorder`),
  ADD KEY `mdlfx_tooluserstep_tou_ix` (`tourid`);

--
-- Indexes for table `mdlfx_tool_usertours_tours`
--
ALTER TABLE `mdlfx_tool_usertours_tours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_upgrade_log`
--
ALTER TABLE `mdlfx_upgrade_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_upgrlog_tim_ix` (`timemodified`),
  ADD KEY `mdlfx_upgrlog_typtim_ix` (`type`,`timemodified`),
  ADD KEY `mdlfx_upgrlog_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_url`
--
ALTER TABLE `mdlfx_url`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_url_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_user`
--
ALTER TABLE `mdlfx_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_user_mneuse_uix` (`mnethostid`,`username`),
  ADD KEY `mdlfx_user_del_ix` (`deleted`),
  ADD KEY `mdlfx_user_con_ix` (`confirmed`),
  ADD KEY `mdlfx_user_fir_ix` (`firstname`),
  ADD KEY `mdlfx_user_las_ix` (`lastname`),
  ADD KEY `mdlfx_user_cit_ix` (`city`),
  ADD KEY `mdlfx_user_cou_ix` (`country`),
  ADD KEY `mdlfx_user_las2_ix` (`lastaccess`),
  ADD KEY `mdlfx_user_ema_ix` (`email`),
  ADD KEY `mdlfx_user_aut_ix` (`auth`),
  ADD KEY `mdlfx_user_idn_ix` (`idnumber`),
  ADD KEY `mdlfx_user_fir2_ix` (`firstnamephonetic`),
  ADD KEY `mdlfx_user_las3_ix` (`lastnamephonetic`),
  ADD KEY `mdlfx_user_mid_ix` (`middlename`),
  ADD KEY `mdlfx_user_alt_ix` (`alternatename`);

--
-- Indexes for table `mdlfx_user_devices`
--
ALTER TABLE `mdlfx_user_devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_userdevi_pususe_uix` (`pushid`,`userid`),
  ADD KEY `mdlfx_userdevi_uuiuse_ix` (`uuid`,`userid`),
  ADD KEY `mdlfx_userdevi_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_user_enrolments`
--
ALTER TABLE `mdlfx_user_enrolments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_userenro_enruse_uix` (`enrolid`,`userid`),
  ADD KEY `mdlfx_userenro_enr_ix` (`enrolid`),
  ADD KEY `mdlfx_userenro_use_ix` (`userid`),
  ADD KEY `mdlfx_userenro_mod_ix` (`modifierid`);

--
-- Indexes for table `mdlfx_user_info_category`
--
ALTER TABLE `mdlfx_user_info_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_user_info_data`
--
ALTER TABLE `mdlfx_user_info_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_userinfodata_usefie_uix` (`userid`,`fieldid`);

--
-- Indexes for table `mdlfx_user_info_field`
--
ALTER TABLE `mdlfx_user_info_field`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_user_lastaccess`
--
ALTER TABLE `mdlfx_user_lastaccess`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_userlast_usecou_uix` (`userid`,`courseid`),
  ADD KEY `mdlfx_userlast_use_ix` (`userid`),
  ADD KEY `mdlfx_userlast_cou_ix` (`courseid`);

--
-- Indexes for table `mdlfx_user_password_history`
--
ALTER TABLE `mdlfx_user_password_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_userpasshist_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_user_password_resets`
--
ALTER TABLE `mdlfx_user_password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_userpassrese_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_user_preferences`
--
ALTER TABLE `mdlfx_user_preferences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_userpref_usenam_uix` (`userid`,`name`);

--
-- Indexes for table `mdlfx_user_private_key`
--
ALTER TABLE `mdlfx_user_private_key`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_userprivkey_scrval_ix` (`script`,`value`),
  ADD KEY `mdlfx_userprivkey_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_wiki`
--
ALTER TABLE `mdlfx_wiki`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_wiki_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_wiki_links`
--
ALTER TABLE `mdlfx_wiki_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_wikilink_fro_ix` (`frompageid`),
  ADD KEY `mdlfx_wikilink_sub_ix` (`subwikiid`);

--
-- Indexes for table `mdlfx_wiki_locks`
--
ALTER TABLE `mdlfx_wiki_locks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdlfx_wiki_pages`
--
ALTER TABLE `mdlfx_wiki_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_wikipage_subtituse_uix` (`subwikiid`,`title`,`userid`),
  ADD KEY `mdlfx_wikipage_sub_ix` (`subwikiid`);

--
-- Indexes for table `mdlfx_wiki_subwikis`
--
ALTER TABLE `mdlfx_wiki_subwikis`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_wikisubw_wikgrouse_uix` (`wikiid`,`groupid`,`userid`),
  ADD KEY `mdlfx_wikisubw_wik_ix` (`wikiid`);

--
-- Indexes for table `mdlfx_wiki_synonyms`
--
ALTER TABLE `mdlfx_wiki_synonyms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_wikisyno_pagpag_uix` (`pageid`,`pagesynonym`);

--
-- Indexes for table `mdlfx_wiki_versions`
--
ALTER TABLE `mdlfx_wiki_versions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_wikivers_pag_ix` (`pageid`);

--
-- Indexes for table `mdlfx_workshop`
--
ALTER TABLE `mdlfx_workshop`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_work_cou_ix` (`course`);

--
-- Indexes for table `mdlfx_workshopallocation_scheduled`
--
ALTER TABLE `mdlfx_workshopallocation_scheduled`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_worksche_wor_uix` (`workshopid`);

--
-- Indexes for table `mdlfx_workshopeval_best_settings`
--
ALTER TABLE `mdlfx_workshopeval_best_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_workbestsett_wor_uix` (`workshopid`);

--
-- Indexes for table `mdlfx_workshopform_accumulative`
--
ALTER TABLE `mdlfx_workshopform_accumulative`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_workaccu_wor_ix` (`workshopid`);

--
-- Indexes for table `mdlfx_workshopform_comments`
--
ALTER TABLE `mdlfx_workshopform_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_workcomm_wor_ix` (`workshopid`);

--
-- Indexes for table `mdlfx_workshopform_numerrors`
--
ALTER TABLE `mdlfx_workshopform_numerrors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_worknume_wor_ix` (`workshopid`);

--
-- Indexes for table `mdlfx_workshopform_numerrors_map`
--
ALTER TABLE `mdlfx_workshopform_numerrors_map`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_worknumemap_wornon_uix` (`workshopid`,`nonegative`),
  ADD KEY `mdlfx_worknumemap_wor_ix` (`workshopid`);

--
-- Indexes for table `mdlfx_workshopform_rubric`
--
ALTER TABLE `mdlfx_workshopform_rubric`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_workrubr_wor_ix` (`workshopid`);

--
-- Indexes for table `mdlfx_workshopform_rubric_config`
--
ALTER TABLE `mdlfx_workshopform_rubric_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_workrubrconf_wor_uix` (`workshopid`);

--
-- Indexes for table `mdlfx_workshopform_rubric_levels`
--
ALTER TABLE `mdlfx_workshopform_rubric_levels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_workrubrleve_dim_ix` (`dimensionid`);

--
-- Indexes for table `mdlfx_workshop_aggregations`
--
ALTER TABLE `mdlfx_workshop_aggregations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_workaggr_woruse_uix` (`workshopid`,`userid`),
  ADD KEY `mdlfx_workaggr_wor_ix` (`workshopid`),
  ADD KEY `mdlfx_workaggr_use_ix` (`userid`);

--
-- Indexes for table `mdlfx_workshop_assessments`
--
ALTER TABLE `mdlfx_workshop_assessments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_workasse_sub_ix` (`submissionid`),
  ADD KEY `mdlfx_workasse_gra_ix` (`gradinggradeoverby`),
  ADD KEY `mdlfx_workasse_rev_ix` (`reviewerid`);

--
-- Indexes for table `mdlfx_workshop_grades`
--
ALTER TABLE `mdlfx_workshop_grades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mdlfx_workgrad_assstrdim_uix` (`assessmentid`,`strategy`,`dimensionid`),
  ADD KEY `mdlfx_workgrad_ass_ix` (`assessmentid`);

--
-- Indexes for table `mdlfx_workshop_submissions`
--
ALTER TABLE `mdlfx_workshop_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mdlfx_worksubm_wor_ix` (`workshopid`),
  ADD KEY `mdlfx_worksubm_gra_ix` (`gradeoverby`),
  ADD KEY `mdlfx_worksubm_aut_ix` (`authorid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mdlfx_analytics_indicator_calc`
--
ALTER TABLE `mdlfx_analytics_indicator_calc`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_analytics_models`
--
ALTER TABLE `mdlfx_analytics_models`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_analytics_models_log`
--
ALTER TABLE `mdlfx_analytics_models_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_analytics_predictions`
--
ALTER TABLE `mdlfx_analytics_predictions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_analytics_prediction_actions`
--
ALTER TABLE `mdlfx_analytics_prediction_actions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_analytics_predict_samples`
--
ALTER TABLE `mdlfx_analytics_predict_samples`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_analytics_train_samples`
--
ALTER TABLE `mdlfx_analytics_train_samples`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_analytics_used_analysables`
--
ALTER TABLE `mdlfx_analytics_used_analysables`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_analytics_used_files`
--
ALTER TABLE `mdlfx_analytics_used_files`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assign`
--
ALTER TABLE `mdlfx_assign`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignfeedback_comments`
--
ALTER TABLE `mdlfx_assignfeedback_comments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignfeedback_editpdf_annot`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_annot`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignfeedback_editpdf_cmnt`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_cmnt`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignfeedback_editpdf_queue`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_queue`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignfeedback_editpdf_quick`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_quick`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignfeedback_editpdf_rot`
--
ALTER TABLE `mdlfx_assignfeedback_editpdf_rot`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignfeedback_file`
--
ALTER TABLE `mdlfx_assignfeedback_file`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignment`
--
ALTER TABLE `mdlfx_assignment`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignment_submissions`
--
ALTER TABLE `mdlfx_assignment_submissions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignment_upgrade`
--
ALTER TABLE `mdlfx_assignment_upgrade`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignsubmission_file`
--
ALTER TABLE `mdlfx_assignsubmission_file`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assignsubmission_onlinetext`
--
ALTER TABLE `mdlfx_assignsubmission_onlinetext`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assign_grades`
--
ALTER TABLE `mdlfx_assign_grades`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assign_overrides`
--
ALTER TABLE `mdlfx_assign_overrides`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assign_plugin_config`
--
ALTER TABLE `mdlfx_assign_plugin_config`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assign_submission`
--
ALTER TABLE `mdlfx_assign_submission`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assign_user_flags`
--
ALTER TABLE `mdlfx_assign_user_flags`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_assign_user_mapping`
--
ALTER TABLE `mdlfx_assign_user_mapping`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_attendance`
--
ALTER TABLE `mdlfx_attendance`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_attendance_log`
--
ALTER TABLE `mdlfx_attendance_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_attendance_rotate_passwords`
--
ALTER TABLE `mdlfx_attendance_rotate_passwords`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_attendance_sessions`
--
ALTER TABLE `mdlfx_attendance_sessions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_attendance_statuses`
--
ALTER TABLE `mdlfx_attendance_statuses`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_attendance_tempusers`
--
ALTER TABLE `mdlfx_attendance_tempusers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_attendance_warning`
--
ALTER TABLE `mdlfx_attendance_warning`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_attendance_warning_done`
--
ALTER TABLE `mdlfx_attendance_warning_done`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_auth_oauth2_linked_login`
--
ALTER TABLE `mdlfx_auth_oauth2_linked_login`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_backup_controllers`
--
ALTER TABLE `mdlfx_backup_controllers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_backup_courses`
--
ALTER TABLE `mdlfx_backup_courses`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_backup_logs`
--
ALTER TABLE `mdlfx_backup_logs`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge`
--
ALTER TABLE `mdlfx_badge`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_alignment`
--
ALTER TABLE `mdlfx_badge_alignment`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_backpack`
--
ALTER TABLE `mdlfx_badge_backpack`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_criteria`
--
ALTER TABLE `mdlfx_badge_criteria`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_criteria_met`
--
ALTER TABLE `mdlfx_badge_criteria_met`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_criteria_param`
--
ALTER TABLE `mdlfx_badge_criteria_param`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_endorsement`
--
ALTER TABLE `mdlfx_badge_endorsement`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_external`
--
ALTER TABLE `mdlfx_badge_external`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_external_backpack`
--
ALTER TABLE `mdlfx_badge_external_backpack`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_external_identifier`
--
ALTER TABLE `mdlfx_badge_external_identifier`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_issued`
--
ALTER TABLE `mdlfx_badge_issued`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_manual_award`
--
ALTER TABLE `mdlfx_badge_manual_award`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_badge_related`
--
ALTER TABLE `mdlfx_badge_related`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_block`
--
ALTER TABLE `mdlfx_block`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_block_instances`
--
ALTER TABLE `mdlfx_block_instances`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_block_positions`
--
ALTER TABLE `mdlfx_block_positions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_block_recentlyaccesseditems`
--
ALTER TABLE `mdlfx_block_recentlyaccesseditems`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_block_recent_activity`
--
ALTER TABLE `mdlfx_block_recent_activity`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_block_rss_client`
--
ALTER TABLE `mdlfx_block_rss_client`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_blog_association`
--
ALTER TABLE `mdlfx_blog_association`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_blog_external`
--
ALTER TABLE `mdlfx_blog_external`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_book`
--
ALTER TABLE `mdlfx_book`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_book_chapters`
--
ALTER TABLE `mdlfx_book_chapters`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_cache_filters`
--
ALTER TABLE `mdlfx_cache_filters`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_cache_flags`
--
ALTER TABLE `mdlfx_cache_flags`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_capabilities`
--
ALTER TABLE `mdlfx_capabilities`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_chat`
--
ALTER TABLE `mdlfx_chat`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_chat_messages`
--
ALTER TABLE `mdlfx_chat_messages`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_chat_messages_current`
--
ALTER TABLE `mdlfx_chat_messages_current`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_chat_users`
--
ALTER TABLE `mdlfx_chat_users`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_choice`
--
ALTER TABLE `mdlfx_choice`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_choice_answers`
--
ALTER TABLE `mdlfx_choice_answers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_choice_options`
--
ALTER TABLE `mdlfx_choice_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_cohort`
--
ALTER TABLE `mdlfx_cohort`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_cohort_members`
--
ALTER TABLE `mdlfx_cohort_members`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_comments`
--
ALTER TABLE `mdlfx_comments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency`
--
ALTER TABLE `mdlfx_competency`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_coursecomp`
--
ALTER TABLE `mdlfx_competency_coursecomp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_coursecompsetting`
--
ALTER TABLE `mdlfx_competency_coursecompsetting`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_evidence`
--
ALTER TABLE `mdlfx_competency_evidence`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_framework`
--
ALTER TABLE `mdlfx_competency_framework`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_modulecomp`
--
ALTER TABLE `mdlfx_competency_modulecomp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_plan`
--
ALTER TABLE `mdlfx_competency_plan`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_plancomp`
--
ALTER TABLE `mdlfx_competency_plancomp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_relatedcomp`
--
ALTER TABLE `mdlfx_competency_relatedcomp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_template`
--
ALTER TABLE `mdlfx_competency_template`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_templatecohort`
--
ALTER TABLE `mdlfx_competency_templatecohort`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_templatecomp`
--
ALTER TABLE `mdlfx_competency_templatecomp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_usercomp`
--
ALTER TABLE `mdlfx_competency_usercomp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_usercompcourse`
--
ALTER TABLE `mdlfx_competency_usercompcourse`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_usercompplan`
--
ALTER TABLE `mdlfx_competency_usercompplan`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_userevidence`
--
ALTER TABLE `mdlfx_competency_userevidence`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_competency_userevidencecomp`
--
ALTER TABLE `mdlfx_competency_userevidencecomp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_config`
--
ALTER TABLE `mdlfx_config`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_config_log`
--
ALTER TABLE `mdlfx_config_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_config_plugins`
--
ALTER TABLE `mdlfx_config_plugins`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_context`
--
ALTER TABLE `mdlfx_context`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course`
--
ALTER TABLE `mdlfx_course`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_categories`
--
ALTER TABLE `mdlfx_course_categories`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_completions`
--
ALTER TABLE `mdlfx_course_completions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_completion_aggr_methd`
--
ALTER TABLE `mdlfx_course_completion_aggr_methd`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_completion_criteria`
--
ALTER TABLE `mdlfx_course_completion_criteria`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_completion_crit_compl`
--
ALTER TABLE `mdlfx_course_completion_crit_compl`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_completion_defaults`
--
ALTER TABLE `mdlfx_course_completion_defaults`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_format_options`
--
ALTER TABLE `mdlfx_course_format_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_modules`
--
ALTER TABLE `mdlfx_course_modules`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_modules_completion`
--
ALTER TABLE `mdlfx_course_modules_completion`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_published`
--
ALTER TABLE `mdlfx_course_published`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_request`
--
ALTER TABLE `mdlfx_course_request`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_course_sections`
--
ALTER TABLE `mdlfx_course_sections`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_customfield_category`
--
ALTER TABLE `mdlfx_customfield_category`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_customfield_data`
--
ALTER TABLE `mdlfx_customfield_data`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_customfield_field`
--
ALTER TABLE `mdlfx_customfield_field`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_data`
--
ALTER TABLE `mdlfx_data`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_data_content`
--
ALTER TABLE `mdlfx_data_content`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_data_fields`
--
ALTER TABLE `mdlfx_data_fields`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_data_records`
--
ALTER TABLE `mdlfx_data_records`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_editor_atto_autosave`
--
ALTER TABLE `mdlfx_editor_atto_autosave`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol`
--
ALTER TABLE `mdlfx_enrol`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_flatfile`
--
ALTER TABLE `mdlfx_enrol_flatfile`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_lti2_consumer`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_consumer`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_lti2_context`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_context`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_lti2_nonce`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_nonce`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_lti2_resource_link`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_resource_link`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_lti2_share_key`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_share_key`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_lti2_tool_proxy`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_tool_proxy`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_lti2_user_result`
--
ALTER TABLE `mdlfx_enrol_lti_lti2_user_result`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_tools`
--
ALTER TABLE `mdlfx_enrol_lti_tools`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_tool_consumer_map`
--
ALTER TABLE `mdlfx_enrol_lti_tool_consumer_map`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_lti_users`
--
ALTER TABLE `mdlfx_enrol_lti_users`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_enrol_paypal`
--
ALTER TABLE `mdlfx_enrol_paypal`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_event`
--
ALTER TABLE `mdlfx_event`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_events_handlers`
--
ALTER TABLE `mdlfx_events_handlers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_events_queue`
--
ALTER TABLE `mdlfx_events_queue`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_events_queue_handlers`
--
ALTER TABLE `mdlfx_events_queue_handlers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_event_subscriptions`
--
ALTER TABLE `mdlfx_event_subscriptions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_external_functions`
--
ALTER TABLE `mdlfx_external_functions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_external_services`
--
ALTER TABLE `mdlfx_external_services`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_external_services_functions`
--
ALTER TABLE `mdlfx_external_services_functions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_external_services_users`
--
ALTER TABLE `mdlfx_external_services_users`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_external_tokens`
--
ALTER TABLE `mdlfx_external_tokens`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_favourite`
--
ALTER TABLE `mdlfx_favourite`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_feedback`
--
ALTER TABLE `mdlfx_feedback`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_feedback_completed`
--
ALTER TABLE `mdlfx_feedback_completed`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_feedback_completedtmp`
--
ALTER TABLE `mdlfx_feedback_completedtmp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_feedback_item`
--
ALTER TABLE `mdlfx_feedback_item`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_feedback_sitecourse_map`
--
ALTER TABLE `mdlfx_feedback_sitecourse_map`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_feedback_template`
--
ALTER TABLE `mdlfx_feedback_template`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_feedback_value`
--
ALTER TABLE `mdlfx_feedback_value`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_feedback_valuetmp`
--
ALTER TABLE `mdlfx_feedback_valuetmp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_files`
--
ALTER TABLE `mdlfx_files`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_files_reference`
--
ALTER TABLE `mdlfx_files_reference`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_file_conversion`
--
ALTER TABLE `mdlfx_file_conversion`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_filter_active`
--
ALTER TABLE `mdlfx_filter_active`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_filter_config`
--
ALTER TABLE `mdlfx_filter_config`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_folder`
--
ALTER TABLE `mdlfx_folder`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum`
--
ALTER TABLE `mdlfx_forum`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_digests`
--
ALTER TABLE `mdlfx_forum_digests`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_discussions`
--
ALTER TABLE `mdlfx_forum_discussions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_discussion_subs`
--
ALTER TABLE `mdlfx_forum_discussion_subs`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_grades`
--
ALTER TABLE `mdlfx_forum_grades`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_posts`
--
ALTER TABLE `mdlfx_forum_posts`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_queue`
--
ALTER TABLE `mdlfx_forum_queue`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_read`
--
ALTER TABLE `mdlfx_forum_read`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_subscriptions`
--
ALTER TABLE `mdlfx_forum_subscriptions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_forum_track_prefs`
--
ALTER TABLE `mdlfx_forum_track_prefs`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_glossary`
--
ALTER TABLE `mdlfx_glossary`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_glossary_alias`
--
ALTER TABLE `mdlfx_glossary_alias`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_glossary_categories`
--
ALTER TABLE `mdlfx_glossary_categories`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_glossary_entries`
--
ALTER TABLE `mdlfx_glossary_entries`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_glossary_entries_categories`
--
ALTER TABLE `mdlfx_glossary_entries_categories`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_glossary_formats`
--
ALTER TABLE `mdlfx_glossary_formats`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_categories`
--
ALTER TABLE `mdlfx_grade_categories`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_categories_history`
--
ALTER TABLE `mdlfx_grade_categories_history`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_grades`
--
ALTER TABLE `mdlfx_grade_grades`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_grades_history`
--
ALTER TABLE `mdlfx_grade_grades_history`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_import_newitem`
--
ALTER TABLE `mdlfx_grade_import_newitem`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_import_values`
--
ALTER TABLE `mdlfx_grade_import_values`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_items`
--
ALTER TABLE `mdlfx_grade_items`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_items_history`
--
ALTER TABLE `mdlfx_grade_items_history`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_letters`
--
ALTER TABLE `mdlfx_grade_letters`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_outcomes`
--
ALTER TABLE `mdlfx_grade_outcomes`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_outcomes_courses`
--
ALTER TABLE `mdlfx_grade_outcomes_courses`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_outcomes_history`
--
ALTER TABLE `mdlfx_grade_outcomes_history`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grade_settings`
--
ALTER TABLE `mdlfx_grade_settings`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_gradingform_guide_comments`
--
ALTER TABLE `mdlfx_gradingform_guide_comments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_gradingform_guide_criteria`
--
ALTER TABLE `mdlfx_gradingform_guide_criteria`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_gradingform_guide_fillings`
--
ALTER TABLE `mdlfx_gradingform_guide_fillings`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_gradingform_rubric_criteria`
--
ALTER TABLE `mdlfx_gradingform_rubric_criteria`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_gradingform_rubric_fillings`
--
ALTER TABLE `mdlfx_gradingform_rubric_fillings`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_gradingform_rubric_levels`
--
ALTER TABLE `mdlfx_gradingform_rubric_levels`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grading_areas`
--
ALTER TABLE `mdlfx_grading_areas`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grading_definitions`
--
ALTER TABLE `mdlfx_grading_definitions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_grading_instances`
--
ALTER TABLE `mdlfx_grading_instances`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_groupings`
--
ALTER TABLE `mdlfx_groupings`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_groupings_groups`
--
ALTER TABLE `mdlfx_groupings_groups`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_groups`
--
ALTER TABLE `mdlfx_groups`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_groups_members`
--
ALTER TABLE `mdlfx_groups_members`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_h5p`
--
ALTER TABLE `mdlfx_h5p`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_h5p_contents_libraries`
--
ALTER TABLE `mdlfx_h5p_contents_libraries`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_h5p_libraries`
--
ALTER TABLE `mdlfx_h5p_libraries`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_h5p_libraries_cachedassets`
--
ALTER TABLE `mdlfx_h5p_libraries_cachedassets`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_h5p_library_dependencies`
--
ALTER TABLE `mdlfx_h5p_library_dependencies`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_imscp`
--
ALTER TABLE `mdlfx_imscp`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_label`
--
ALTER TABLE `mdlfx_label`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lesson`
--
ALTER TABLE `mdlfx_lesson`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lesson_answers`
--
ALTER TABLE `mdlfx_lesson_answers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lesson_attempts`
--
ALTER TABLE `mdlfx_lesson_attempts`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lesson_branch`
--
ALTER TABLE `mdlfx_lesson_branch`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lesson_grades`
--
ALTER TABLE `mdlfx_lesson_grades`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lesson_overrides`
--
ALTER TABLE `mdlfx_lesson_overrides`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lesson_pages`
--
ALTER TABLE `mdlfx_lesson_pages`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lesson_timer`
--
ALTER TABLE `mdlfx_lesson_timer`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_license`
--
ALTER TABLE `mdlfx_license`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lock_db`
--
ALTER TABLE `mdlfx_lock_db`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_log`
--
ALTER TABLE `mdlfx_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_logstore_standard_log`
--
ALTER TABLE `mdlfx_logstore_standard_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_log_display`
--
ALTER TABLE `mdlfx_log_display`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_log_queries`
--
ALTER TABLE `mdlfx_log_queries`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lti`
--
ALTER TABLE `mdlfx_lti`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_ltiservice_gradebookservices`
--
ALTER TABLE `mdlfx_ltiservice_gradebookservices`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lti_access_tokens`
--
ALTER TABLE `mdlfx_lti_access_tokens`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lti_submission`
--
ALTER TABLE `mdlfx_lti_submission`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lti_tool_proxies`
--
ALTER TABLE `mdlfx_lti_tool_proxies`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lti_tool_settings`
--
ALTER TABLE `mdlfx_lti_tool_settings`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lti_types`
--
ALTER TABLE `mdlfx_lti_types`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_lti_types_config`
--
ALTER TABLE `mdlfx_lti_types_config`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message`
--
ALTER TABLE `mdlfx_message`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_messageinbound_datakeys`
--
ALTER TABLE `mdlfx_messageinbound_datakeys`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_messageinbound_handlers`
--
ALTER TABLE `mdlfx_messageinbound_handlers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_messageinbound_messagelist`
--
ALTER TABLE `mdlfx_messageinbound_messagelist`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_messages`
--
ALTER TABLE `mdlfx_messages`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_airnotifier_devices`
--
ALTER TABLE `mdlfx_message_airnotifier_devices`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_contacts`
--
ALTER TABLE `mdlfx_message_contacts`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_contact_requests`
--
ALTER TABLE `mdlfx_message_contact_requests`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_conversations`
--
ALTER TABLE `mdlfx_message_conversations`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_conversation_actions`
--
ALTER TABLE `mdlfx_message_conversation_actions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_conversation_members`
--
ALTER TABLE `mdlfx_message_conversation_members`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_email_messages`
--
ALTER TABLE `mdlfx_message_email_messages`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_popup`
--
ALTER TABLE `mdlfx_message_popup`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_popup_notifications`
--
ALTER TABLE `mdlfx_message_popup_notifications`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_processors`
--
ALTER TABLE `mdlfx_message_processors`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_providers`
--
ALTER TABLE `mdlfx_message_providers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_read`
--
ALTER TABLE `mdlfx_message_read`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_users_blocked`
--
ALTER TABLE `mdlfx_message_users_blocked`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_message_user_actions`
--
ALTER TABLE `mdlfx_message_user_actions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnetservice_enrol_courses`
--
ALTER TABLE `mdlfx_mnetservice_enrol_courses`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnetservice_enrol_enrolments`
--
ALTER TABLE `mdlfx_mnetservice_enrol_enrolments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_application`
--
ALTER TABLE `mdlfx_mnet_application`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_host`
--
ALTER TABLE `mdlfx_mnet_host`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_host2service`
--
ALTER TABLE `mdlfx_mnet_host2service`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_log`
--
ALTER TABLE `mdlfx_mnet_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_remote_rpc`
--
ALTER TABLE `mdlfx_mnet_remote_rpc`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_remote_service2rpc`
--
ALTER TABLE `mdlfx_mnet_remote_service2rpc`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_rpc`
--
ALTER TABLE `mdlfx_mnet_rpc`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_service`
--
ALTER TABLE `mdlfx_mnet_service`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_service2rpc`
--
ALTER TABLE `mdlfx_mnet_service2rpc`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_session`
--
ALTER TABLE `mdlfx_mnet_session`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_mnet_sso_access_control`
--
ALTER TABLE `mdlfx_mnet_sso_access_control`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_modules`
--
ALTER TABLE `mdlfx_modules`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_my_pages`
--
ALTER TABLE `mdlfx_my_pages`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_notifications`
--
ALTER TABLE `mdlfx_notifications`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_oauth2_access_token`
--
ALTER TABLE `mdlfx_oauth2_access_token`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_oauth2_endpoint`
--
ALTER TABLE `mdlfx_oauth2_endpoint`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_oauth2_issuer`
--
ALTER TABLE `mdlfx_oauth2_issuer`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_oauth2_system_account`
--
ALTER TABLE `mdlfx_oauth2_system_account`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_oauth2_user_field_mapping`
--
ALTER TABLE `mdlfx_oauth2_user_field_mapping`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_page`
--
ALTER TABLE `mdlfx_page`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_portfolio_instance`
--
ALTER TABLE `mdlfx_portfolio_instance`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_portfolio_instance_config`
--
ALTER TABLE `mdlfx_portfolio_instance_config`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_portfolio_instance_user`
--
ALTER TABLE `mdlfx_portfolio_instance_user`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_portfolio_log`
--
ALTER TABLE `mdlfx_portfolio_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_portfolio_mahara_queue`
--
ALTER TABLE `mdlfx_portfolio_mahara_queue`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_portfolio_tempdata`
--
ALTER TABLE `mdlfx_portfolio_tempdata`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_post`
--
ALTER TABLE `mdlfx_post`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_profiling`
--
ALTER TABLE `mdlfx_profiling`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_ddimageortext`
--
ALTER TABLE `mdlfx_qtype_ddimageortext`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_ddimageortext_drags`
--
ALTER TABLE `mdlfx_qtype_ddimageortext_drags`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_ddimageortext_drops`
--
ALTER TABLE `mdlfx_qtype_ddimageortext_drops`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_ddmarker`
--
ALTER TABLE `mdlfx_qtype_ddmarker`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_ddmarker_drags`
--
ALTER TABLE `mdlfx_qtype_ddmarker_drags`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_ddmarker_drops`
--
ALTER TABLE `mdlfx_qtype_ddmarker_drops`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_essay_options`
--
ALTER TABLE `mdlfx_qtype_essay_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_match_options`
--
ALTER TABLE `mdlfx_qtype_match_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_match_subquestions`
--
ALTER TABLE `mdlfx_qtype_match_subquestions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_multichoice_options`
--
ALTER TABLE `mdlfx_qtype_multichoice_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_randomsamatch_options`
--
ALTER TABLE `mdlfx_qtype_randomsamatch_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_qtype_shortanswer_options`
--
ALTER TABLE `mdlfx_qtype_shortanswer_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question`
--
ALTER TABLE `mdlfx_question`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_answers`
--
ALTER TABLE `mdlfx_question_answers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_attempts`
--
ALTER TABLE `mdlfx_question_attempts`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_attempt_steps`
--
ALTER TABLE `mdlfx_question_attempt_steps`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_attempt_step_data`
--
ALTER TABLE `mdlfx_question_attempt_step_data`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_calculated`
--
ALTER TABLE `mdlfx_question_calculated`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_calculated_options`
--
ALTER TABLE `mdlfx_question_calculated_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_categories`
--
ALTER TABLE `mdlfx_question_categories`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_datasets`
--
ALTER TABLE `mdlfx_question_datasets`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_dataset_definitions`
--
ALTER TABLE `mdlfx_question_dataset_definitions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_dataset_items`
--
ALTER TABLE `mdlfx_question_dataset_items`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_ddwtos`
--
ALTER TABLE `mdlfx_question_ddwtos`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_gapselect`
--
ALTER TABLE `mdlfx_question_gapselect`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_hints`
--
ALTER TABLE `mdlfx_question_hints`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_multianswer`
--
ALTER TABLE `mdlfx_question_multianswer`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_numerical`
--
ALTER TABLE `mdlfx_question_numerical`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_numerical_options`
--
ALTER TABLE `mdlfx_question_numerical_options`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_numerical_units`
--
ALTER TABLE `mdlfx_question_numerical_units`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_response_analysis`
--
ALTER TABLE `mdlfx_question_response_analysis`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_response_count`
--
ALTER TABLE `mdlfx_question_response_count`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_statistics`
--
ALTER TABLE `mdlfx_question_statistics`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_truefalse`
--
ALTER TABLE `mdlfx_question_truefalse`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_question_usages`
--
ALTER TABLE `mdlfx_question_usages`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz`
--
ALTER TABLE `mdlfx_quiz`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_attempts`
--
ALTER TABLE `mdlfx_quiz_attempts`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_feedback`
--
ALTER TABLE `mdlfx_quiz_feedback`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_grades`
--
ALTER TABLE `mdlfx_quiz_grades`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_overrides`
--
ALTER TABLE `mdlfx_quiz_overrides`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_overview_regrades`
--
ALTER TABLE `mdlfx_quiz_overview_regrades`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_reports`
--
ALTER TABLE `mdlfx_quiz_reports`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_sections`
--
ALTER TABLE `mdlfx_quiz_sections`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_slots`
--
ALTER TABLE `mdlfx_quiz_slots`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_slot_tags`
--
ALTER TABLE `mdlfx_quiz_slot_tags`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_quiz_statistics`
--
ALTER TABLE `mdlfx_quiz_statistics`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_rating`
--
ALTER TABLE `mdlfx_rating`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_registration_hubs`
--
ALTER TABLE `mdlfx_registration_hubs`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_repository`
--
ALTER TABLE `mdlfx_repository`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_repository_instances`
--
ALTER TABLE `mdlfx_repository_instances`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_repository_instance_config`
--
ALTER TABLE `mdlfx_repository_instance_config`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_repository_onedrive_access`
--
ALTER TABLE `mdlfx_repository_onedrive_access`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_resource`
--
ALTER TABLE `mdlfx_resource`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_resource_old`
--
ALTER TABLE `mdlfx_resource_old`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role`
--
ALTER TABLE `mdlfx_role`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role_allow_assign`
--
ALTER TABLE `mdlfx_role_allow_assign`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role_allow_override`
--
ALTER TABLE `mdlfx_role_allow_override`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role_allow_switch`
--
ALTER TABLE `mdlfx_role_allow_switch`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role_allow_view`
--
ALTER TABLE `mdlfx_role_allow_view`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role_assignments`
--
ALTER TABLE `mdlfx_role_assignments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role_capabilities`
--
ALTER TABLE `mdlfx_role_capabilities`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role_context_levels`
--
ALTER TABLE `mdlfx_role_context_levels`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_role_names`
--
ALTER TABLE `mdlfx_role_names`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scale`
--
ALTER TABLE `mdlfx_scale`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scale_history`
--
ALTER TABLE `mdlfx_scale_history`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm`
--
ALTER TABLE `mdlfx_scorm`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_aicc_session`
--
ALTER TABLE `mdlfx_scorm_aicc_session`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_scoes`
--
ALTER TABLE `mdlfx_scorm_scoes`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_scoes_data`
--
ALTER TABLE `mdlfx_scorm_scoes_data`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_scoes_track`
--
ALTER TABLE `mdlfx_scorm_scoes_track`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_seq_mapinfo`
--
ALTER TABLE `mdlfx_scorm_seq_mapinfo`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_seq_objective`
--
ALTER TABLE `mdlfx_scorm_seq_objective`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_seq_rolluprule`
--
ALTER TABLE `mdlfx_scorm_seq_rolluprule`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_seq_rolluprulecond`
--
ALTER TABLE `mdlfx_scorm_seq_rolluprulecond`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_seq_rulecond`
--
ALTER TABLE `mdlfx_scorm_seq_rulecond`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_scorm_seq_ruleconds`
--
ALTER TABLE `mdlfx_scorm_seq_ruleconds`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_search_index_requests`
--
ALTER TABLE `mdlfx_search_index_requests`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_search_simpledb_index`
--
ALTER TABLE `mdlfx_search_simpledb_index`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_sessions`
--
ALTER TABLE `mdlfx_sessions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_stats_daily`
--
ALTER TABLE `mdlfx_stats_daily`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_stats_monthly`
--
ALTER TABLE `mdlfx_stats_monthly`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_stats_user_daily`
--
ALTER TABLE `mdlfx_stats_user_daily`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_stats_user_monthly`
--
ALTER TABLE `mdlfx_stats_user_monthly`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_stats_user_weekly`
--
ALTER TABLE `mdlfx_stats_user_weekly`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_stats_weekly`
--
ALTER TABLE `mdlfx_stats_weekly`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_survey`
--
ALTER TABLE `mdlfx_survey`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_survey_analysis`
--
ALTER TABLE `mdlfx_survey_analysis`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_survey_answers`
--
ALTER TABLE `mdlfx_survey_answers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_survey_questions`
--
ALTER TABLE `mdlfx_survey_questions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tag`
--
ALTER TABLE `mdlfx_tag`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tag_area`
--
ALTER TABLE `mdlfx_tag_area`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tag_coll`
--
ALTER TABLE `mdlfx_tag_coll`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tag_correlation`
--
ALTER TABLE `mdlfx_tag_correlation`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tag_instance`
--
ALTER TABLE `mdlfx_tag_instance`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_task_adhoc`
--
ALTER TABLE `mdlfx_task_adhoc`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_task_log`
--
ALTER TABLE `mdlfx_task_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_task_scheduled`
--
ALTER TABLE `mdlfx_task_scheduled`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_cohortroles`
--
ALTER TABLE `mdlfx_tool_cohortroles`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_customlang`
--
ALTER TABLE `mdlfx_tool_customlang`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_customlang_components`
--
ALTER TABLE `mdlfx_tool_customlang_components`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_dataprivacy_category`
--
ALTER TABLE `mdlfx_tool_dataprivacy_category`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_dataprivacy_ctxexpired`
--
ALTER TABLE `mdlfx_tool_dataprivacy_ctxexpired`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_dataprivacy_ctxinstance`
--
ALTER TABLE `mdlfx_tool_dataprivacy_ctxinstance`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_dataprivacy_ctxlevel`
--
ALTER TABLE `mdlfx_tool_dataprivacy_ctxlevel`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_dataprivacy_purpose`
--
ALTER TABLE `mdlfx_tool_dataprivacy_purpose`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_dataprivacy_purposerole`
--
ALTER TABLE `mdlfx_tool_dataprivacy_purposerole`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_dataprivacy_request`
--
ALTER TABLE `mdlfx_tool_dataprivacy_request`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_monitor_events`
--
ALTER TABLE `mdlfx_tool_monitor_events`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_monitor_history`
--
ALTER TABLE `mdlfx_tool_monitor_history`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_monitor_rules`
--
ALTER TABLE `mdlfx_tool_monitor_rules`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_monitor_subscriptions`
--
ALTER TABLE `mdlfx_tool_monitor_subscriptions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_policy`
--
ALTER TABLE `mdlfx_tool_policy`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_policy_acceptances`
--
ALTER TABLE `mdlfx_tool_policy_acceptances`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_policy_versions`
--
ALTER TABLE `mdlfx_tool_policy_versions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_recyclebin_category`
--
ALTER TABLE `mdlfx_tool_recyclebin_category`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_recyclebin_course`
--
ALTER TABLE `mdlfx_tool_recyclebin_course`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_usertours_steps`
--
ALTER TABLE `mdlfx_tool_usertours_steps`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_tool_usertours_tours`
--
ALTER TABLE `mdlfx_tool_usertours_tours`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_upgrade_log`
--
ALTER TABLE `mdlfx_upgrade_log`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_url`
--
ALTER TABLE `mdlfx_url`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user`
--
ALTER TABLE `mdlfx_user`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_devices`
--
ALTER TABLE `mdlfx_user_devices`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_enrolments`
--
ALTER TABLE `mdlfx_user_enrolments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_info_category`
--
ALTER TABLE `mdlfx_user_info_category`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_info_data`
--
ALTER TABLE `mdlfx_user_info_data`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_info_field`
--
ALTER TABLE `mdlfx_user_info_field`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_lastaccess`
--
ALTER TABLE `mdlfx_user_lastaccess`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_password_history`
--
ALTER TABLE `mdlfx_user_password_history`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_password_resets`
--
ALTER TABLE `mdlfx_user_password_resets`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_preferences`
--
ALTER TABLE `mdlfx_user_preferences`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_user_private_key`
--
ALTER TABLE `mdlfx_user_private_key`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_wiki`
--
ALTER TABLE `mdlfx_wiki`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_wiki_links`
--
ALTER TABLE `mdlfx_wiki_links`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_wiki_locks`
--
ALTER TABLE `mdlfx_wiki_locks`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_wiki_pages`
--
ALTER TABLE `mdlfx_wiki_pages`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_wiki_subwikis`
--
ALTER TABLE `mdlfx_wiki_subwikis`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_wiki_synonyms`
--
ALTER TABLE `mdlfx_wiki_synonyms`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_wiki_versions`
--
ALTER TABLE `mdlfx_wiki_versions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshop`
--
ALTER TABLE `mdlfx_workshop`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopallocation_scheduled`
--
ALTER TABLE `mdlfx_workshopallocation_scheduled`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopeval_best_settings`
--
ALTER TABLE `mdlfx_workshopeval_best_settings`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopform_accumulative`
--
ALTER TABLE `mdlfx_workshopform_accumulative`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopform_comments`
--
ALTER TABLE `mdlfx_workshopform_comments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopform_numerrors`
--
ALTER TABLE `mdlfx_workshopform_numerrors`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopform_numerrors_map`
--
ALTER TABLE `mdlfx_workshopform_numerrors_map`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopform_rubric`
--
ALTER TABLE `mdlfx_workshopform_rubric`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopform_rubric_config`
--
ALTER TABLE `mdlfx_workshopform_rubric_config`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshopform_rubric_levels`
--
ALTER TABLE `mdlfx_workshopform_rubric_levels`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshop_aggregations`
--
ALTER TABLE `mdlfx_workshop_aggregations`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshop_assessments`
--
ALTER TABLE `mdlfx_workshop_assessments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshop_grades`
--
ALTER TABLE `mdlfx_workshop_grades`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mdlfx_workshop_submissions`
--
ALTER TABLE `mdlfx_workshop_submissions`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
