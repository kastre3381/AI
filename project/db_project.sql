-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 17, 2026 at 06:00 AM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_project`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `id_order` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `order_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id_order`, `id_user`, `order_date`) VALUES
(1, 1, '2026-01-03'),
(2, 1, '2026-01-03'),
(3, 1, '2026-01-04'),
(4, 4, '2026-01-04'),
(5, 1, '2026-01-10');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `order_items`
--

CREATE TABLE `order_items` (
  `id_order_items` int(11) NOT NULL,
  `id_products` int(11) NOT NULL,
  `id_orders` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id_order_items`, `id_products`, `id_orders`, `price`, `quantity`) VALUES
(1, 9, 1, 32, 3),
(2, 3, 1, 899, 1),
(3, 11, 2, 57, 1),
(4, 7, 2, 59, 1),
(5, 1, 2, 4499, 1),
(6, 1, 3, 4499, 3),
(7, 11, 4, 57, 6),
(8, 15, 4, 110, 1),
(9, 7, 4, 59, 1),
(10, 11, 5, 57, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products`
--

CREATE TABLE `products` (
  `id_product` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id_product`, `name`, `description`, `image_url`, `quantity`, `price`) VALUES
(1, 'Telewizor TCL 65C7K 65\" QD-Mini LED 4K 144Hz', 'Technologia QD-Mini LED w telewizorze TCL 65C7K łączy zalety OLED i QLED. Dzięki przemyślanemu podświetleniu obraz zyskuje kontrast i głębię. Oglądanie filmów i seriali staje się prawdziwą ucztą dla oczu – wyraźnie widać każdy detal.\r\n\r\nQuantum Dot umożliwia wyświetlanie ponad miliona barw. Kolory są intensywne, a jednocześnie naturalne. Dzięki temu obrazy są bliskie rzeczywistości, co poprawia przyjemność z oglądania.\r\n\r\nTechnologia 4K HDR PREMIUM w telewizorze TCL 65C7K gwarantuje dobry kontrast i szczegóły. Obraz porywa jasnością i głębią nawet w ciemnych scenach. Każdy film wygląda jak kinowa produkcja.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/75/7596681/Telewizor-TCL-65C7K-0.jpg', 6, 4499.00),
(2, 'Telewizor LIN 32LHD1810', 'Prosty telewizor HD do codziennego oglądania kanałów i serwisów VOD. Dobra opcja do małego pokoju lub kuchni.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/64/6407756/Telewizor-LIN-32LHD1810-skos01.jpg', 47, 599.00),
(3, 'Laptop MAXCOM Office mBook Lite', 'Lekki laptop do podstawowych zadań: internet, dokumenty i nauka. Sprawdzi się jako tani komputer do domu.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/65/6578304/Laptop-MAXCOM-Office-mBook-Lite-frontowe.jpg', 17, 899.00),
(4, 'Laptop KRUGER_MATZ Edge 1089S', 'Kompaktowy laptop/tablet 2w1 z dotykowym ekranem do pracy mobilnej. Dobry do notatek, przeglądania i prostych aplikacji.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/39/3944830/Laptop-KRUGER_MATZ-Edge-1089S-ekran-dotykowy-1.jpg', 63, 1299.00),
(5, 'Odkurzacz MPM MOD-53', 'Odkurzacz workowy do podstawowego sprzątania mieszkania. Ma klasyczną konstrukcję i zestaw końcówek do różnych powierzchni.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/68/6814728/Odkurzacz-MPM-MOD-53-zestaw-1.jpg', 72, 199.00),
(6, 'Odkurzacz PRIME3 SVC21', 'Niedrogi odkurzacz workowy do szybkiego sprzątania podłóg i dywanów. Prosta obsługa i regulacja pracy w zależności od potrzeb.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/21/2183493/Odkurzacz-PRIME3-SVC21-front-1.jpg', 29, 199.00),
(7, 'Telefon MYPHONE 2320 Czarny', 'Klasyczny telefon z klawiaturą, nastawiony na rozmowy i SMS. Mały, prosty i wygodny jako awaryjny lub dla seniora.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/29/2916706/Telefon-MYPHONE-2220-Czarny-front.jpg', 0, 159.00),
(8, 'Telefon MAXCOM MM135L Light Czarno-niebieski', 'Prosty telefon z fizyczną klawiaturą i podstawowymi funkcjami. Dobre rozwiązanie dla osób, które nie potrzebują smartfona.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/58/5873264/Telefon-MAXCOM-MM135L-Light-Czarno-niebieski-front-tyl.jpg', 55, 59.90),
(9, 'Słuchawki dokanałowe XIAOMI Redmi Buds 6 Play', 'Lekkie słuchawki Bluetooth do telefonu i treningu. Długi czas pracy z etui i stabilne połączenie bezprzewodowe.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/69/6959196/Sluchawki-dokanalowe-XIAOMI-Redmi-Buds-6-Play-Wodoodporne-Bialy-front.jpg', 88, 31.52),
(10, 'Konsola MY ARCADE Classic Tetris DGUNL-7030', 'Przenośna mini-konsola do gry w Tetris. Ma wbudowaną grę i jest łatwa do zabrania w podróż.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/62/6295182/Konsola-MY-ARCADE-Classic-Tetris-DGUNL-7030-front.jpg', 14, 109.99),
(11, 'Ekspres ESPERANZA Robusta EKC006', 'Mały ekspres przelewowy do przygotowania kilku filiżanek kawy. Prosta obsługa i kompaktowy rozmiar na blat kuchenny.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/23/2305234/Ekspres-ESPERANZA-Robusta-EKC006-front__1.jpg', 223, 57.00),
(12, 'Telewizor LIN 32LHD1810 32\" LED Slim', 'Kompaktowy telewizor 32\" do kuchni lub małego pokoju. Prosty w obsłudze i wystarczający do codziennego oglądania kanałów oraz VOD.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/64/6407756/Telewizor-LIN-32LHD1810-skos01.jpg', 84, 499.99),
(13, 'Odkurzacz MPM MOD-53', 'Klasyczny odkurzacz workowy do podstawowego sprzątania mieszkania. Sprawdzi się do podłóg i dywanów, ma standardowe akcesoria.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/68/6814728/Odkurzacz-MPM-MOD-53-zestaw-1.jpg', 57, 199.00),
(15, 'Konsola MY ARCADE Classic Tetris DGUNL-7030', 'Przenośna mini-konsola z wbudowanym Tetrisem. Idealna do szybkiej rozrywki w podróży.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/62/6295182/Konsola-MY-ARCADE-Classic-Tetris-DGUNL-7030-front.jpg', 115, 109.99),
(16, 'Laptop ASUS Vivobook 15 M1502YA R5-7430U 16/5', 'Uniwersalny laptop 15,6\" do pracy i nauki. Dobry kompromis między wydajnością a ceną.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/80/8056363/Laptop-ASUS-VivoBook-15-M1502YA-1.jpg', 41, 2069.23),
(17, 'Laptop APPLE MacBook Air 2025 M4 16/256GB 13.', 'Smukły MacBook Air z układem M4 do codziennej pracy, nauki i multimediów. Cichy, lekki i mobilny.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/75/7553716/MacBook-Air-2025-01.jpg', 19, 4354.53),
(18, 'Słuchawki nauszne PANASONIC RB-HF420BE-K Czar', 'Bezprzewodowe słuchawki Bluetooth do codziennego słuchania. Wygodne nauszniki i prosta obsługa.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/24/2409914/Sluchawki-nauszne-PANASONIC-RB-HF420BE-K-Czarny-sluchawka-1.jpg', 132, 79.99),
(19, 'Słuchawki nauszne SONY WHCH520 Kremowy', 'Lekkie słuchawki Bluetooth do telefonu i laptopa. Dobre do muzyki, podcastów i rozmów.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/52/5217042/Sluchawki-nauszne-SONY-WH-CH520-Kremowy-skos1.jpg', 68, 112.10),
(20, 'Słuchawki douszne APPLE EarPods MWTY3ZM/A Lig', 'Przewodowe słuchawki do iPhone’a ze złączem Lightning. Stabilne połączenie i pilot na kablu.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/11/1128455/11.JPG', 97, 109.99),
(21, 'Telefon MYPHONE 2220 Czarny', 'Prosty telefon z klawiaturą do rozmów i SMS. Dobry jako zapasowy lub dla osób ceniących prostotę.', 'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/29/2916706/Telefon-MYPHONE-2220-Czarny-front.jpg', 155, 59.00);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `birth_date` date NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp(),
  `type` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `name`, `surname`, `email`, `password`, `birth_date`, `created_at`, `type`) VALUES
(1, 'Kacper', 'Tracz', 'kt@gmail.com', '$2y$10$bd5Nf1SGIBTpE7MmPm8h4edjL6h54hyHKO2zme8za0e95jCtEwqN6', '2000-10-11', '2026-01-03', 0),
(4, 'admin', 'admin', 'admin@gmail.com', '$2y$10$kHyzWux53GZKMzjg1ESnbuMgZO36r5JN8cpwOr1dc4GVmemyk7ix6', '2026-01-20', '2026-01-03', 1);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `idx_orders_user` (`id_user`);

--
-- Indeksy dla tabeli `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id_order_items`),
  ADD KEY `idx_order_items_orders` (`id_orders`),
  ADD KEY `idx_order_items_products` (`id_products`);

--
-- Indeksy dla tabeli `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id_product`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id_order_items` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_users` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`id_orders`) REFERENCES `orders` (`id_order`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_order_items_products` FOREIGN KEY (`id_products`) REFERENCES `products` (`id_product`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
