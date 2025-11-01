<?php require_once dirname(__FILE__) .'/../config.php';?>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">
<head>
<meta charset="utf-8" />
<title>Kalkulator kredytowy</title>
</head>
<body>

<form action="<?php print(_APP_URL);?>/app/credit_calc.php" method="post">
	<label for="id_price">Kwota kredytu: </label>
	<input id="id_price" type="text" name="price" value="<?php if(isset($price)) print($price); ?>" /><br />
	<label for="id_time">Okres spłaty kredytu (w latach): </label>
	<input id="id_time" type="text" name="time" value="<?php if(isset($time)) print($time); ?>" /><br />
	<label for="id_percentage">Oprocentowanie (>=0%): </label>
	<input id="id_percentage" type="text" name="percentage" value="<?php if(isset($percentage)) print($percentage); ?>" /><br />
	<input type="submit" value="Oblicz miesięczną ratę" />
</form>	

<?php
//wyświeltenie listy błędów, jeśli istnieją
if (isset($messages)) {
	if (count ( $messages ) > 0) {
		echo '<ol style="margin: 20px; padding: 10px 10px 10px 30px; border-radius: 5px; background-color: #f88; width:300px;">';
		foreach ( $messages as $key => $msg ) {
			echo '<li>'.$msg.'</li>';
		}
		echo '</ol>';
	}
}
?>

<?php if (isset($result)){ ?>
<div style="margin: 20px; padding: 10px; border-radius: 5px; background-color: #ff0; width:300px;">
<?php echo 'Całkowita miesięczna kwota: '.$result; ?>
</div>
<?php } ?>

</body>
</html>