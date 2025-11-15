<?php
require_once dirname(__FILE__).'/../config.php';

include _ROOT_PATH.'/app/security/check.php';

function getParams( &$price, 
                   &$time, 
                   &$percentage )
{
    // 0) Pobranie parametrów 
    $price       = isset( $_REQUEST[ 'price' ] ) ? trim( $_REQUEST[ 'price' ] ) : null;
    $time        = isset( $_REQUEST[ 'time' ] ) ? trim( $_REQUEST[ 'time' ] ) : null;
    $percentage  = isset( $_REQUEST[ 'percentage' ] ) ? trim( $_REQUEST[ 'percentage' ] ) : null;
}

function validate( &$price, 
                   &$time, 
                   &$percentage,
                   &$messages )
{
    // 1) Sprawdzenie obecności parametrów
    if( !( isset( $price ) && 
           isset( $time ) && 
           isset( $percentage ) ) ) 
    {
        $messages[] = 'Błędne wywołanie aplikacji. Brak jednego z parametrów.';
    }

    // 2) Walidacja pustych wartości
    if( $price === '' || 
         $price === null ) 
    {
        $messages[] = 'Nie podano wartości kredytu.';
    }
    if( $time === '' || 
        $time === null ) 
    {
        $messages[] = 'Nie podano czasu spłaty kredytu (w latach).';
    }
    if( $percentage === '' || 
        $percentage === null ) 
    {
        $messages[] = 'Nie podano oprocentowania.';
    }

    // 3) Walidacja typów i zakresów
    if( empty( $messages ) ) 
    {
        // Zamiana przecinka na kropkę 
        $price = str_replace( ',', 
                              '.', 
                              $price );

        $time = str_replace( ',', 
                             '.', 
                             $time );

        $percentage = str_replace( ',', 
                                   '.', 
                                   $percentage );

        if( !is_numeric( $price ) ) 
        {
            $messages[] = 'Kwota kredytu musi być liczbą.';
        }

        if( !is_numeric( $time ) ) 
        {
            $messages[] = 'Okres spłaty (lata) musi być liczbą.';
        }

        if( !is_numeric( $percentage ) ) 
        {
            $messages[] = 'Oprocentowanie musi być liczbą.';
        }

        if( empty( $messages ) ) 
        {
            $price = ( float )$price;
            $time = ( float )$time;
            $percentage = ( float )$percentage;

            if( $price <= 0 ) 
            {
                $messages[] = 'Kwota kredytu musi być większa od zera.';
            }

            if( $time <= 0 ) 
            {
                $messages[] = 'Okres spłaty (lata) musi być większy od zera.';
            }

            if( $percentage < 0 ) 
            {
                $messages[] = 'Oprocentowanie nie może być ujemne.';
            }
        }
    }

    if( count( $messages ) > 0 )
    {
        return false;
    }
    return true;
}

function process( &$price, 
                  &$time, 
                  &$percentage,
                  &$messages,
                  &$result )
{
    // 4) Obliczenia
    if( empty( $messages ) ) 
    {
        $n = ( int )round( $time * 12 );                 // liczba miesięcy
        if( $n <= 0 ) 
        {
            $messages[] = 'Okres spłaty po przeliczeniu na miesiące musi być dodatni.';
        } 
        else 
        {
            $r = ( $percentage / 100.0 ) / 12.0;       // miesięczna stopa
            if( $r == 0.0 ) 
            {
                $payment = $price / $n;
            } 
            else 
            {
                // rata annuitetowa: P  r  (1+r)^n / ((1+r)^n - 1)
                $factor = pow( 1 + $r, $n );
                $payment = $factor / ( $factor - 1 );
            }
            // Zaokrąglenie do 2 miejsc (np. zł)
            $result = number_format( $payment, 
                                     2, 
                                     ',', 
                                     ' ' );
        }
    }
}

$price = null;
$time = null;
$percentage = null;
$result = null;
$messages = array();

getParams( $price, $time, $operation );
if( validate( $price, $time, $operation, $messages ) ) 
{ 
	process( $price, $time, $operation, $messages, $result );
}

// 5) Wywołanie widoku z przekazaniem zmiennych
include 'credit_calc_view.php';