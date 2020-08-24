-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 28 Jan 2018 pada 04.09
-- Versi Server: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_polyclinic_v1`
CREATE DATABASE db_poluclinic_v1;
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteTransaction` (IN `kode_transaksi` INT(11))  BEGIN
		DELETE FROM table_transaction WHERE ID_TRANSACTION = kode_transaksi;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SearchPatientID` (IN `id` INT(11))  BEGIN
		select * from table_transaction where ID_PATIENT= id;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Transaction` (IN `price` DECIMAL(18,0), `qty` DECIMAL(18,0), `tarifLab` DECIMAL(18,0), `tarifDokter` DECIMAL(18,0))  BEGIN
		insert into table_transaction (Amount) values(tarifLab+tarifDokter+(price*qty));
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TransactionThisMonth` (IN `monthid` INT(11))  BEGIN
	select * from table_transaction where TRANSACTIONDATE = monthid;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VIewHistoryPatient` (IN `id` INT(11))  BEGIN
	  select * from history where ID_PATIENT = id;
	END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `assurance`
--

CREATE TABLE `assurance` (
  `ID_ASSURANCE` int(11) NOT NULL,
  `ID_PATIENT` int(11) DEFAULT NULL,
  `ASSURANCENAME` varchar(100) DEFAULT NULL,
  `PLATFOND` decimal(18,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `diagnosa_obat`
--

CREATE TABLE `diagnosa_obat` (
  `ID_MEDICINE` int(11) NOT NULL,
  `ID_DIAGNOSIS` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `diagnosis`
--

CREATE TABLE `diagnosis` (
  `ID_DIAGNOSIS` int(11) NOT NULL,
  `ID_DOCTOR` int(11) DEFAULT NULL,
  `ID_PATIENT` int(11) DEFAULT NULL,
  `ID_TRANSACTION` int(11) DEFAULT NULL,
  `NOTE` text,
  `ATTRIBUTE_TANG50` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Struktur dari tabel `doctor`
--

CREATE TABLE `doctor` (
  `ID_DOCTOR` int(11) NOT NULL,
  `NAME` varchar(200) DEFAULT NULL,
  `ADDRESS` text,
  `CONTACT` varchar(15) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `TARIF` decimal(18,0) DEFAULT NULL,
  `LAB_DOCTOR` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `history`
--

CREATE TABLE `history` (
  `ID_HISTORY` int(11) NOT NULL,
  `ID_PATIENT` int(11) DEFAULT NULL,
  `ID_DOCTOR` int(11) DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `PENYAKIT` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `lab_test`
--

CREATE TABLE `lab_test` (
  `ID_LAB` int(11) NOT NULL,
  `TARIF_LAB` decimal(18,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `patient`
--

CREATE TABLE `patient` (
  `ID_PATIENT` int(11) NOT NULL,
  `NO_KTP` varchar(100) DEFAULT NULL,
  `AGE` int(11) DEFAULT NULL,
  `NAME` varchar(200) DEFAULT NULL,
  `ADDRESS` text,
  `GENDER` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `payment`
--

CREATE TABLE `payment` (
  `ID_PAYMENT` int(11) NOT NULL,
  `PAYMENTTYPE` varchar(50) DEFAULT NULL,
  `BANK` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `specialist`
--

CREATE TABLE `specialist` (
  `ID_SPECIALIST` int(11) NOT NULL,
  `ID_DOCTOR` int(11) DEFAULT NULL,
  `SPECIALISTNAME` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `table_medicine`
--

CREATE TABLE `table_medicine` (
  `ID_MEDICINE` int(11) NOT NULL,
  `MEDICINE` varchar(200) DEFAULT NULL,
  `TYPE_MEDICINE` varchar(100) DEFAULT NULL,
  `PRICE` float(8,2) DEFAULT NULL,
  `STOCK` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktur dari tabel `table_transaction`
--

CREATE TABLE `table_transaction` (
  `ID_TRANSACTION` int(11) NOT NULL,
  `ID_PAYMENT` int(11) DEFAULT NULL,
  `ID_LAB` int(11) DEFAULT NULL,
  `ID_DIAGNOSIS` int(11) DEFAULT NULL,
  `ID_DOCTOR` int(11) DEFAULT NULL,
  `ID_PATIENT` int(11) DEFAULT NULL,
  `AMOUNT` decimal(18,0) DEFAULT NULL,
  `TRANSACTIONDATE` date DEFAULT NULL,
  `NORREGISTER` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Stand-in structure for view `viewpatient`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `viewpatient` (
`ID_PATIENT` int(11)
,`NO_KTP` varchar(100)
,`AGE` int(11)
,`NAME` varchar(200)
,`ADDRESS` text
,`GENDER` char(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `viewtransactionmonth`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `viewtransactionmonth` (
`ID_TRANSACTION` int(11)
,`ID_PAYMENT` int(11)
,`ID_LAB` int(11)
,`ID_DIAGNOSIS` int(11)
,`ID_DOCTOR` int(11)
,`ID_PATIENT` int(11)
,`AMOUNT` decimal(18,0)
,`TRANSACTIONDATE` date
,`NORREGISTER` int(11)
);

CREATE TABLE perubahan_transaksi(
	id_transaksi INT(11),
	id_payment INT(11),
	harga_baru INT(30),
	harga_lama INT(30),
	id_pasien INT(11),
	waktu_perubahan date
);
 

--
-- Indexes for table `assurance`
--
ALTER TABLE `assurance`
  ADD PRIMARY KEY (`ID_ASSURANCE`),
  ADD KEY `FK_PEMBAYARAN_LEWAT_ASURANSI` (`ID_PATIENT`);

--
-- Indexes for table `diagnosa_obat`
--
ALTER TABLE `diagnosa_obat`
  ADD PRIMARY KEY (`ID_MEDICINE`,`ID_DIAGNOSIS`),
  ADD KEY `FK_DIAGNOSA_OBAT2` (`ID_DIAGNOSIS`);

--
-- Indexes for table `diagnosis`
--
ALTER TABLE `diagnosis`
  ADD PRIMARY KEY (`ID_DIAGNOSIS`),
  ADD KEY `FK_DIAGNOSA` (`ID_PATIENT`),
  ADD KEY `FK_DIAGNOSA_DOKTER` (`ID_DOCTOR`),
  ADD KEY `FK_TRANSAKSI_DIAGNOSA` (`ID_TRANSACTION`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`ID_DOCTOR`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`ID_HISTORY`),
  ADD KEY `FK_DIPERIKSA` (`ID_DOCTOR`),
  ADD KEY `FK_HISTORYUSER` (`ID_PATIENT`);

--
-- Indexes for table `lab_test`
--
ALTER TABLE `lab_test`
  ADD PRIMARY KEY (`ID_LAB`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`ID_PATIENT`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`ID_PAYMENT`);

--
-- Indexes for table `specialist`
--
ALTER TABLE `specialist`
  ADD PRIMARY KEY (`ID_SPECIALIST`),
  ADD KEY `FK_SPESIALIS_PEKERJAAN` (`ID_DOCTOR`);

--
-- Indexes for table `table_medicine`
--
ALTER TABLE `table_medicine`
  ADD PRIMARY KEY (`ID_MEDICINE`);

--
-- Indexes for table `table_transaction`
--
ALTER TABLE `table_transaction`
  ADD PRIMARY KEY (`ID_TRANSACTION`),
  ADD KEY `FK_PEMERIKSA` (`ID_DOCTOR`),
  ADD KEY `FK_TEST_LAB_PASIEN` (`ID_LAB`),
  ADD KEY `FK_TIPE_PEMBAYARAN` (`ID_PAYMENT`),
  ADD KEY `FK_TRANSAKSI` (`ID_PATIENT`),
  ADD KEY `FK_TRANSAKSI_DIAGNOSA2` (`ID_DIAGNOSIS`);
--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `ID_HISTORY` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Dumping data untuk tabel `assurance`
--
INSERT INTO `assurance` (`ID_ASSURANCE`, `ID_PATIENT`, `ASSURANCENAME`, `PLATFOND`) VALUES
(200132, 100125, 'Great Eastrn', '2000000'),
(200313, 100120, 'BPJS KETENAGAKERJAAN', '1500000');
-- --------------------------------------------------------

--
-- Dumping data untuk tabel `diagnosa_obat`
--
INSERT INTO `diagnosa_obat` (`ID_MEDICINE`, `ID_DIAGNOSIS`) VALUES
(101, 19),
(101, 30),
(101, 41),
(101, 52),
(101, 63),
(102, 2),
(102, 9),
(102, 20),
(102, 31),
(102, 42),
(102, 53),
(102, 64),
(103, 10),
(103, 21),
(103, 32),
(103, 43),
(103, 54),
(103, 65),
(104, 1),
(104, 3),
(104, 11),
(104, 22),
(104, 33),
(104, 44),
(104, 55),
(105, 12),
(105, 23),
(105, 34),
(105, 45),
(105, 56),
(106, 13),
(106, 24),
(106, 35),
(106, 46),
(106, 57),
(107, 14),
(107, 25),
(107, 36),
(107, 47),
(107, 58),
(108, 4),
(108, 5),
(108, 15),
(108, 26),
(108, 37),
(108, 48),
(108, 59),
(109, 6),
(109, 16),
(109, 27),
(109, 38),
(109, 49),
(109, 60),
(110, 7),
(110, 17),
(110, 28),
(110, 39),
(110, 50),
(110, 61),
(111, 8),
(111, 18),
(111, 29),
(111, 40),
(111, 51),
(111, 62);
-- --------------------------------------------------------

--
-- Dumping data untuk tabel `diagnosis`
--
INSERT INTO `diagnosis` (`ID_DIAGNOSIS`, `ID_DOCTOR`, `ID_PATIENT`, `ID_TRANSACTION`, `NOTE`, `ATTRIBUTE_TANG50`) VALUES
(1, 200233, 100125, 2, '-', '2017-11-15 11:00:00'),
(2, 200232, 100121, NULL, '-', '2017-11-15 10:00:00'),
(3, 200234, 100120, 101, '-', '2017-11-16 11:00:00'),
(4, 200235, 100123, NULL, '-', '2017-11-16 12:00:00'),
(5, 200235, 100124, NULL, '-', '2017-11-17 10:00:00'),
(6, 200232, 100122, NULL, '-', '2017-11-17 15:00:00'),
(7, 200235, 100126, NULL, '-', '2017-11-18 10:00:00'),
(8, 200233, 100127, NULL, '-', '2017-11-18 15:00:00'),
(9, 200234, 100128, NULL, '-', '2017-11-20 11:00:00'),
(10, 200234, 100129, NULL, '-', '2017-11-20 14:00:00'),
(11, 200232, 100130, NULL, '-', '2017-11-22 10:00:00'),
(12, 200236, 100131, NULL, '-', '2017-11-23 09:00:00'),
(13, 200232, 100132, NULL, '-', '2017-11-25 10:00:00'),
(14, 200236, 100123, NULL, '-', '2017-11-28 11:00:00'),
(15, 200234, 100126, NULL, '-', '2017-11-29 11:00:00'),
(16, 200231, 100131, NULL, '-', '2017-11-30 11:00:00'),
(17, 200232, 100126, NULL, '-', '2017-12-01 11:00:00'),
(18, 200234, 100133, NULL, '-', '2017-12-02 11:00:00'),
(19, 200235, 100129, NULL, '-', '2017-12-03 11:00:00'),
(20, 200232, 100121, NULL, '-', '2017-12-04 11:00:00'),
(21, 200231, 100128, NULL, '-', '2017-12-05 11:00:00'),
(22, 200236, 100126, NULL, '-', '2017-12-06 11:00:00'),
(23, 200230, 100127, NULL, '-', '2017-12-07 10:00:00'),
(24, 200230, 100128, NULL, '-', '2017-12-08 12:00:00'),
(25, 200230, 100131, NULL, '-', '2017-12-08 11:00:00'),
(26, 200230, 100125, NULL, '-', '2017-12-09 10:00:00'),
(27, 200230, 100126, NULL, '-', '2017-12-10 12:00:00'),
(28, 200230, 100129, NULL, '-', '2017-12-11 10:00:00'),
(29, 200230, 100121, NULL, '-', '2017-12-12 09:00:00'),
(30, 200230, 100120, NULL, '-', '2017-12-13 09:00:00'),
(31, 200230, 100132, NULL, '-', '2017-12-14 10:00:00'),
(32, 200230, 100133, NULL, '-', '2017-12-15 11:00:00'),
(33, 200234, 100126, NULL, '-', '2018-01-09 08:00:00'),
(34, 200234, 100126, NULL, '-', '2018-01-10 08:00:00'),
(35, 200234, 100126, NULL, '-', '2018-01-11 09:00:00'),
(36, 200234, 100131, NULL, '-', '2018-01-11 10:00:00'),
(37, 200234, 100134, NULL, '-', '2018-01-12 08:00:00'),
(38, 200234, 100128, NULL, '-', '2018-01-12 12:00:00'),
(39, 200234, 100129, NULL, '-', '2018-01-13 08:00:00'),
(40, 200234, 100130, NULL, '-', '2018-01-14 08:00:00'),
(41, 200234, 100123, NULL, '-', '2018-01-15 08:00:00'),
(42, 200234, 100127, NULL, '-', '2018-01-16 08:00:00'),
(43, 200234, 100129, NULL, '-', '2018-01-17 08:00:00'),
(44, 200234, 100123, NULL, '-', '2018-01-18 08:00:00'),
(45, 200234, 100125, NULL, '-', '2018-01-19 08:00:00'),
(46, 200234, 100132, NULL, '-', '2018-01-20 08:00:00'),
(47, 200234, 100133, NULL, '-', '2018-01-21 08:00:00'),
(48, 200231, 100132, NULL, '-', '2017-12-22 10:00:00'),
(49, 200234, 100134, NULL, '-', '2017-12-24 08:00:00'),
(50, 200231, 100131, NULL, '-', '2017-12-24 10:00:00'),
(51, 200234, 100129, NULL, '-', '2018-01-01 08:00:00'),
(52, 200232, 100121, NULL, '-', '2018-01-01 12:00:00'),
(53, 200233, 100122, NULL, '-', '2018-01-02 08:00:00'),
(54, 200234, 100123, NULL, '-', '2018-01-03 08:00:00'),
(55, 200235, 100134, NULL, '-', '2018-01-04 08:00:00'),
(56, 200236, 100125, NULL, '-', '2018-01-05 08:00:00'),
(57, 200231, 100134, NULL, '-', '2018-01-06 08:00:00'),
(58, 200232, 100124, NULL, '-', '2018-01-07 08:00:00'),
(59, 200233, 100126, NULL, '-', '2018-01-08 08:00:00'),
(60, 200234, 100127, NULL, '-', '2018-01-09 08:00:00'),
(61, 200235, 100128, NULL, '-', '2018-01-10 08:00:00'),
(62, 200236, 100129, NULL, '-', '2018-01-11 08:00:00'),
(63, 200234, 100131, NULL, '-', '2018-01-12 08:00:00'),
(64, 200236, 100133, NULL, '-', '2018-01-13 08:00:00'),
(65, 200232, 100130, NULL, '-', '2018-01-14 08:00:00');

--
-- Trigger `diagnosis`
--
DELIMITER $$
CREATE TRIGGER `historyUser` AFTER INSERT ON `diagnosis` FOR EACH ROW BEGIN
	INSERT into history(ID_PATIENT, ID_DOCTOR, DATE, PENYAKIT) VALUES(new.ID_PATIENT, new.ID_DOCTOR, NOW(), new.NOTE);
    END
$$
DELIMITER ;
-- --------------------------------------------------------

--
-- Dumping data untuk tabel `doctor`
--
INSERT INTO `doctor` (`ID_DOCTOR`, `NAME`, `ADDRESS`, `CONTACT`, `START_DATE`, `TARIF`, `LAB_DOCTOR`) VALUES
(200230, 'Max', 'Jakarta', '0822992512', '2018-01-01', '20000', NULL),
(200231, 'Renaldi', 'Jakarta', NULL, '2018-01-01', '22000', NULL),
(200232, 'Budi', 'Jakarta', NULL, '2017-07-01', '25000', NULL),
(200233, 'Edwin', 'Jakarta', NULL, '2017-08-01', '20000', NULL),
(200234, 'Chen', 'Jakarta', '02122533512', '2017-08-01', '23000', NULL),
(200235, 'Melda', 'Jakarta', '02180860212', '2018-01-01', '32000', NULL),
(200236, 'Diansastro', 'Jakarta', NULL, '2017-11-01', '25000', NULL);

-- --------------------------------------------------------

--
-- Dumping data untuk tabel `history`
--
INSERT INTO `history` (`ID_HISTORY`, `ID_PATIENT`, `ID_DOCTOR`, `DATE`, `PENYAKIT`) VALUES
(1, 100120, 200230, '2018-01-28', '-'),
(2, 100121, 200232, '2018-01-28', '-'),
(3, 100120, 200234, '2018-01-28', '-'),
(4, 100123, 200235, '2018-01-28', '-'),
(5, 100124, 200235, '2018-01-28', '-'),
(6, 100122, 200232, '2018-01-28', '-'),
(7, 100126, 200235, '2018-01-28', '-'),
(8, 100127, 200233, '2018-01-28', '-'),
(9, 100128, 200234, '2018-01-28', '-'),
(10, 100129, 200234, '2018-01-28', '-'),
(11, 100130, 200232, '2018-01-28', '-'),
(12, 100131, 200236, '2018-01-28', '-'),
(13, 100132, 200232, '2018-01-28', '-'),
(14, 100123, 200236, '2018-01-28', '-'),
(15, 100126, 200234, '2018-01-28', '-'),
(16, 100126, 200231, '2018-01-28', '-'),
(17, 100126, 200232, '2018-01-28', '-'),
(18, 100126, 200234, '2018-01-28', '-'),
(19, 100126, 200235, '2018-01-28', '-'),
(20, 100126, 200232, '2018-01-28', '-'),
(21, 100126, 200231, '2018-01-28', '-'),
(22, 100126, 200236, '2018-01-28', '-'),
(23, 100127, 200230, '2018-01-28', '-'),
(24, 100128, 200230, '2018-01-28', '-'),
(25, 100131, 200230, '2018-01-28', '-'),
(26, 100125, 200230, '2018-01-28', '-'),
(27, 100126, 200230, '2018-01-28', '-'),
(28, 100129, 200230, '2018-01-28', '-'),
(29, 100121, 200230, '2018-01-28', '-'),
(30, 100120, 200230, '2018-01-28', '-'),
(31, 100132, 200230, '2018-01-28', '-'),
(32, 100133, 200230, '2018-01-28', '-'),
(33, 100126, 200234, '2018-01-28', '-'),
(34, 100126, 200234, '2018-01-28', '-'),
(35, 100126, 200234, '2018-01-28', '-'),
(36, 100131, 200234, '2018-01-28', '-'),
(37, 100134, 200234, '2018-01-28', '-'),
(38, 100128, 200234, '2018-01-28', '-'),
(39, 100129, 200234, '2018-01-28', '-'),
(40, 100130, 200234, '2018-01-28', '-'),
(41, 100123, 200234, '2018-01-28', '-'),
(42, 100127, 200234, '2018-01-28', '-'),
(43, 100129, 200234, '2018-01-28', '-'),
(44, 100123, 200234, '2018-01-28', '-'),
(45, 100125, 200234, '2018-01-28', '-'),
(46, 100132, 200234, '2018-01-28', '-'),
(47, 100133, 200234, '2018-01-28', '-'),
(48, 100132, 200231, '2018-01-28', '-'),
(49, 100134, 200234, '2018-01-28', '-'),
(50, 100131, 200231, '2018-01-28', '-'),
(51, 100129, 200234, '2018-01-28', '-'),
(52, 100121, 200232, '2018-01-28', '-'),
(53, 100122, 200233, '2018-01-28', '-'),
(54, 100123, 200234, '2018-01-28', '-'),
(55, 100134, 200235, '2018-01-28', '-'),
(56, 100125, 200236, '2018-01-28', '-'),
(57, 100134, 200231, '2018-01-28', '-'),
(58, 100124, 200232, '2018-01-28', '-'),
(59, 100126, 200233, '2018-01-28', '-'),
(60, 100127, 200234, '2018-01-28', '-'),
(61, 100128, 200235, '2018-01-28', '-'),
(62, 100129, 200236, '2018-01-28', '-'),
(63, 100131, 200234, '2018-01-28', '-'),
(64, 100133, 200236, '2018-01-28', '-'),
(65, 100130, 200232, '2018-01-28', '-');

-- --------------------------------------------------------

--
-- Dumping data untuk tabel `lab_test`
--
INSERT INTO `lab_test` (`ID_LAB`, `TARIF_LAB`) VALUES
(1, '50000'),
(2, '50000'),
(3, '20000'),
(4, '30000'),
(5, '40000');

-- --------------------------------------------------------

--
-- Dumping data untuk tabel `patient`
--
INSERT INTO `patient` (`ID_PATIENT`, `NO_KTP`, `AGE`, `NAME`, `ADDRESS`, `GENDER`) VALUES
(100120, '7070081', 19, 'Max', 'Jakarta', 'M'),
(100121, '12286362', 20, 'Den', 'Jakarta', 'M'),
(100122, '12286362', 20, 'Den', 'Jakarta', 'M'),
(100123, '12200533', 40, 'Annisa', 'Jakarta', 'F'),
(100124, '12216313', 31, 'Ben', 'Jakarta', 'M'),
(100125, '12248422', 60, 'jarwo', 'Jakarta', 'M'),
(100126, '12281841', 20, 'lisa', 'Jakarta', 'F'),
(100127, '7070081', 23, 'Denisa', 'Jakarta', 'F'),
(100128, '7070081', 23, 'Denisa', 'Jakarta', 'F'),
(100129, '5510333', 51, 'Richard', 'Jakarta', 'M'),
(100130, '8133331', 29, 'Dwi', 'Jakarta', 'F'),
(100131, '1825220', 51, 'Gian', 'Jakarta', 'M'),
(100132, '8133833', 40, 'Herni', 'Jakarta', 'F'),
(100133, '7007022', 20, 'Dewa', 'Jakarta', 'M'),
(100134, '9216668', 24, 'siska', 'Jakarta', 'F');

-- --------------------------------------------------------

--
-- Dumping data untuk tabel `payment`
--

INSERT INTO `payment` (`ID_PAYMENT`, `PAYMENTTYPE`, `BANK`) VALUES
(1, 'Debit', 'BCA'),
(2, 'Debit', 'BCA'),
(3, 'Debit', 'Mandiri'),
(4, 'Debit', 'BRI'),
(5, 'Debit', 'VISA'),
(6, 'Credit Card', 'BCA'),
(7, 'Credit Card', 'Mandiri'),
(8, 'Credit Card', 'BRI'),
(9, 'Credit Card', 'Visa');

-- --------------------------------------------------------


--
-- Dumping data untuk tabel `specialist`
--

INSERT INTO `specialist` (`ID_SPECIALIST`, `ID_DOCTOR`, `SPECIALISTNAME`) VALUES
(1, 200230, 'THT'),
(2, 200231, 'Umum'),
(3, 200232, 'Gigi'),
(4, 200234, 'Kardiologi'),
(5, 200235, 'Audiologi'),
(202333, 200233, 'Spesialis anak');

-- --------------------------------------------------------

--
-- Dumping data untuk tabel `table_medicine`
--

INSERT INTO `table_medicine` (`ID_MEDICINE`, `MEDICINE`, `TYPE_MEDICINE`, `PRICE`, `STOCK`) VALUES
(101, 'Paracetamol', 'Generic', 16000.00, 100),
(102, 'Atorvastatin', 'Generic', 40000.00, 300),
(103, 'Sinfastatin', 'Generic', 56000.00, 300),
(104, 'Mirasic', 'Generic', 36000.00, 100),
(105, 'Enzycomb', 'Generic', 16000.00, 100),
(106, 'Farsix', 'Generic', 30000.00, 100),
(107, 'Ondansetron', 'Generic', 18500.00, 100),
(108, 'Lodia', 'Generic', 25000.00, 100),
(109, 'Carpiaton', 'Generic', 34000.00, 100),
(110, 'Lodecon', 'Generic', 16000.00, 100),
(111, 'Episan', 'Non Generic', 60000.00, 100);

-- --------------------------------------------------------

--
-- Dumping data untuk tabel `table_transaction`
--

INSERT INTO `table_transaction` (`ID_TRANSACTION`, `ID_PAYMENT`, `ID_LAB`, `ID_DIAGNOSIS`, `ID_DOCTOR`, `ID_PATIENT`, `AMOUNT`, `TRANSACTIONDATE`, `NORREGISTER`) VALUES
(2, 4, NULL, 1, 200233, 100125, '56000', '2017-11-16', 2),
(4, 4, NULL, 4, 200235, 100123, '57000', '2018-01-15', 4),
(5, 2, NULL, 5, 200235, 100123, '130000', '2018-01-15', 3),
(12, 2, NULL, 12, 200236, 100123, '25000', '2018-01-15', 10),
(13, 4, NULL, 13, 200232, 100123, '57000', '2018-01-15', 11),
(14, 5, NULL, 14, 200236, 100123, '120000', '2018-01-15', 12),
(15, 6, NULL, 15, 200234, 100123, '135000', '2018-01-15', 13),
(16, 1, NULL, 16, 200231, 100123, '57000', '2018-01-15', 14),
(17, 2, NULL, 17, 200232, 100123, '60000', '2018-01-15', 15),
(18, 3, NULL, 18, 200234, 100123, '62000', '2018-01-15', 16),
(19, 4, NULL, 19, 200235, 100123, '57000', '2018-01-15', 17),
(20, 5, NULL, 20, 200232, 100123, '100000', '2018-01-15', 18),
(21, 6, NULL, 21, 200231, 100123, '57000', '2018-01-15', 19),
(22, 7, NULL, 22, 200236, 100123, '40000', '2018-01-15', 20),
(23, 8, NULL, 23, 200230, 100123, '45000', '2018-01-15', 21),
(24, 9, NULL, 24, 200230, 100123, '55000', '2018-01-15', 22),
(25, 1, NULL, 25, 200230, 100123, '60000', '2018-01-15', 23),
(26, 2, NULL, 26, 200230, 100123, '61000', '2018-01-15', 24),
(27, 3, NULL, 27, 200230, 100123, '63000', '2018-01-15', 25),
(28, 4, NULL, 28, 200230, 100123, '66000', '2018-01-15', 26),
(29, 5, NULL, 29, 200230, 100123, '91000', '2018-01-15', 27),
(30, 6, NULL, 30, 200230, 100123, '25000', '2018-01-15', 28),
(31, 7, NULL, 31, 200230, 100123, '57000', '2018-01-15', 29),
(32, 8, NULL, 32, 200230, 100123, '64000', '2018-01-15', 30),
(33, 9, NULL, 33, 200234, 100123, '34000', '2018-01-15', 31),
(34, 1, NULL, 34, 200234, 100123, '71000', '2018-01-15', 32),
(35, 2, NULL, 35, 200234, 100123, '69000', '2018-01-15', 33),
(36, 3, NULL, 36, 200234, 100123, '46000', '2018-01-15', 34),
(37, 4, NULL, 37, 200234, 100123, '49000', '2018-01-15', 35),
(38, 5, NULL, 38, 200234, 100123, '53000', '2018-01-15', 36),
(39, 6, NULL, 39, 200234, 100123, '57000', '2018-01-15', 37),
(40, 7, NULL, 40, 200234, 100123, '120000', '2018-01-15', 38),
(41, 8, NULL, 41, 200234, 100123, '101000', '2018-01-15', 39),
(42, 9, NULL, 42, 200234, 100123, '65000', '2018-01-15', 40),
(43, 1, NULL, 43, 200234, 100123, '70000', '2018-01-15', 41),
(44, 2, NULL, 44, 200234, 100123, '57000', '2018-01-15', 42),
(45, 3, NULL, 45, 200234, 100123, '100000', '2018-01-15', 43),
(46, 4, NULL, 46, 200234, 100123, '120000', '2018-01-15', 44),
(47, 5, NULL, 47, 200234, 100123, '30000', '2018-01-15', 45),
(48, 6, NULL, 48, 200231, 100123, '26000', '2018-01-15', 46),
(49, 7, NULL, 49, 200234, 100123, '30000', '2018-01-15', 47),
(50, 8, NULL, 50, 200231, 100123, '75000', '2018-01-15', 48),
(51, 9, NULL, 51, 200234, 100123, '60000', '2018-01-15', 49),
(52, 1, NULL, 52, 200232, 100123, '72000', '2018-01-15', 50),
(53, 2, NULL, 53, 200233, 100123, '90000', '2018-01-15', 51),
(54, 3, NULL, 54, 200234, 100123, '50000', '2018-01-15', 52),
(55, 4, NULL, 55, 200235, 100123, '62000', '2018-01-15', 53),
(56, 5, NULL, 56, 200236, 100123, '64000', '2018-01-15', 54),
(57, 6, NULL, 57, 200231, 100123, '67000', '2018-01-15', 55),
(58, 7, NULL, 58, 200232, 100123, '69000', '2018-01-15', 56),
(59, 8, NULL, 59, 200233, 100123, '57000', '2018-01-15', 57),
(60, 9, NULL, 60, 200234, 100123, '100000', '2018-01-15', 58),
(61, 1, NULL, 61, 200235, 100123, '160000', '2018-01-15', 59),
(62, 2, NULL, 62, 200236, 100123, '120000', '2018-01-15', 60),
(63, 3, NULL, 63, 200234, 100123, '90000', '2018-01-15', 61),
(64, 4, NULL, 64, 200236, 100123, '57000', '2018-01-15', 62),
(65, 6, NULL, 65, 200232, 100123, '50000', '2018-01-15', 63),
(101, 1, NULL, 1, 200231, 100134, '120000', '2017-11-01', 1),
(102, 3, NULL, 2, 200232, 100121, '40000', '2017-11-16', 2);

-- --------------------------------------------------------

--
-- Ketidakleluasaan untuk tabel `assurance`
--
ALTER TABLE `assurance`
  ADD CONSTRAINT `FK_PEMBAYARAN_LEWAT_ASURANSI` FOREIGN KEY (`ID_PATIENT`) REFERENCES `patient` (`ID_PATIENT`);

--
-- Ketidakleluasaan untuk tabel `diagnosa_obat`
--
ALTER TABLE `diagnosa_obat`
  ADD CONSTRAINT `FK_DIAGNOSA_OBAT` FOREIGN KEY (`ID_MEDICINE`) REFERENCES `table_medicine` (`ID_MEDICINE`),
  ADD CONSTRAINT `FK_DIAGNOSA_OBAT2` FOREIGN KEY (`ID_DIAGNOSIS`) REFERENCES `diagnosis` (`ID_DIAGNOSIS`);

--
-- Ketidakleluasaan untuk tabel `diagnosis`
--
ALTER TABLE `diagnosis`
  ADD CONSTRAINT `FK_DIAGNOSA` FOREIGN KEY (`ID_PATIENT`) REFERENCES `patient` (`ID_PATIENT`),
  ADD CONSTRAINT `FK_DIAGNOSA_DOKTER` FOREIGN KEY (`ID_DOCTOR`) REFERENCES `doctor` (`ID_DOCTOR`),
  ADD CONSTRAINT `FK_TRANSAKSI_DIAGNOSA` FOREIGN KEY (`ID_TRANSACTION`) REFERENCES `table_transaction` (`ID_TRANSACTION`);

--
-- Ketidakleluasaan untuk tabel `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `FK_DIPERIKSA` FOREIGN KEY (`ID_DOCTOR`) REFERENCES `doctor` (`ID_DOCTOR`),
  ADD CONSTRAINT `FK_HISTORYUSER` FOREIGN KEY (`ID_PATIENT`) REFERENCES `patient` (`ID_PATIENT`);

--
-- Ketidakleluasaan untuk tabel `specialist`
--
ALTER TABLE `specialist`
  ADD CONSTRAINT `FK_SPESIALIS_PEKERJAAN` FOREIGN KEY (`ID_DOCTOR`) REFERENCES `doctor` (`ID_DOCTOR`);

--
-- Ketidakleluasaan untuk tabel `table_transaction`
--
ALTER TABLE `table_transaction`
  ADD CONSTRAINT `FK_PEMERIKSA` FOREIGN KEY (`ID_DOCTOR`) REFERENCES `doctor` (`ID_DOCTOR`),
  ADD CONSTRAINT `FK_TEST_LAB_PASIEN` FOREIGN KEY (`ID_LAB`) REFERENCES `lab_test` (`ID_LAB`),
  ADD CONSTRAINT `FK_TIPE_PEMBAYARAN` FOREIGN KEY (`ID_PAYMENT`) REFERENCES `payment` (`ID_PAYMENT`),
  ADD CONSTRAINT `FK_TRANSAKSI` FOREIGN KEY (`ID_PATIENT`) REFERENCES `patient` (`ID_PATIENT`),
  ADD CONSTRAINT `FK_TRANSAKSI_DIAGNOSA2` FOREIGN KEY (`ID_DIAGNOSIS`) REFERENCES `diagnosis` (`ID_DIAGNOSIS`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

--
-- Struktur untuk view `viewpatient`
--
DROP TABLE IF EXISTS `viewpatient`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewpatient`  AS  
(select `patient`.`ID_PATIENT` AS `ID_PATIENT`,`patient`.`NO_KTP` AS `NO_KTP`,`patient`.`AGE` AS `AGE`,`patient`.`NAME` 
	AS `NAME`,`patient`.`ADDRESS` AS `ADDRESS`,`patient`.`GENDER` AS `GENDER` from `patient`);
	
-- --------------------------------------------------------

--
-- Struktur untuk view `viewtransactionmonth`
--
DROP TABLE IF EXISTS `viewtransactionmonth`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewtransactionmonth`  AS  
(select `table_transaction`.`ID_TRANSACTION` AS `ID_TRANSACTION`,`table_transaction`.`ID_PAYMENT` AS `ID_PAYMENT`,`table_transaction`.`ID_LAB` 
	AS `ID_LAB`,`table_transaction`.`ID_DIAGNOSIS` AS `ID_DIAGNOSIS`,`table_transaction`.`ID_DOCTOR` AS `ID_DOCTOR`,`table_transaction`.`ID_PATIENT` 
	AS `ID_PATIENT`,`table_transaction`.`AMOUNT` AS `AMOUNT`,`table_transaction`.`TRANSACTIONDATE` AS `TRANSACTIONDATE`,`table_transaction`.`NORREGISTER` 
	AS `NORREGISTER` from `table_transaction` 
where (`table_transaction`.`TRANSACTIONDATE` = '01')) ;

--
-- Indexes for dumped tables
--


-- Trigger `view Patient table`

DELIMITER $$

ALTER ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewpatient`

AS (

SELECT

`patient`.`ID_PATIENT` AS `ID_PATIENT`,

`patient`.`NO_KTP`	AS `NO_KTP`,

`patient`.`AGE`	AS `AGE`,

`patient`.`NAME`	AS `NAME`,

`patient`.`ADDRESS`	AS `ADDRESS`,

`patient`.`GENDER`	AS `GENDER`

FROM `patient`)$$

DELIMITER ;


--
-- trigger for record deleted data
--
DELIMITER $$

CREATE TRIGGER Updated_transaction_amount
    BEFORE UPDATE ON `table_transaction`
    FOR EACH ROW 
BEGIN
    INSERT INTO perubahan_transaksi
    set 
		 id_transaksi = OLD.`ID_TRANSACTION`,
		 
	    id_payment=old.`ID_PAYMENT`,
	    
	    id_pasien=old.`ID_PATIENT`,
	    
	    harga_lama=old.`AMOUNT`,
	    
	    harga_baru=new.`AMOUNT`,
	    
	    waktu_perubahan = NOW(); 
END$$

DELIMITER ;

--
-- update 1 data to display on Updated_transaction (for testing)
--
update `table_transaction` set`AMOUNT`='81000' WHERE `ID_TRANSACTION`=65;
update `table_transaction` set`AMOUNT`='90000' WHERE `ID_TRANSACTION`=12;
update `table_transaction` set`AMOUNT`='90000' WHERE `ID_TRANSACTION`=15;


--
-- hasil data yang sudah diupdate 
--

SELECT * FROM perubahan_transaksi;

-- Trigger `view transaction month`

DELIMITER $$

ALTER ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewtransactionmonth`

AS (

SELECT

`table_transaction`.`ID_TRANSACTION` AS `ID_TRANSACTION`,

`table_transaction`.`ID_PAYMENT`	AS `ID_PAYMENT`,

`table_transaction`.`ID_LAB`	AS `ID_LAB`,

`table_transaction`.`ID_DIAGNOSIS`	AS `ID_DIAGNOSIS`,

`table_transaction`.`ID_DOCTOR`	AS `ID_DOCTOR`,

`table_transaction`.`ID_PATIENT`	AS `ID_PATIENT`,

`table_transaction`.`AMOUNT`	AS `AMOUNT`,

`table_transaction`.`TRANSACTIONDATE`	AS `TRANSACTIONDATE`,

`table_transaction`.`NORREGISTER`	AS `NORREGISTER`

FROM `table_transaction`)$$

DELIMITER ;