<?php

require_once dirname(__FILE__).'/../forms/CalcForm.class.php';
require_once dirname(__FILE__).'/../results/CalcResult.class.php';
require_once dirname(__FILE__).'/../../lib/Messages.class.php';

class CalcCtrl {

    private $form;   
    private $result; 
    private $msgs;   

    // a. konstruktor 
    public function __construct() {
        $this->form = new CalcForm();
        $this->result = new CalcResult();
        $this->msgs = new Messages();
    }

    // b. metoda pobierająca parametry
    public function getParams() {
        $this->form->price      = isset($_REQUEST['price']) ? trim($_REQUEST['price']) : null;
        $this->form->time       = isset($_REQUEST['time']) ? trim($_REQUEST['time']) : null;
        $this->form->percentage = isset($_REQUEST['percentage']) ? trim($_REQUEST['percentage']) : null;
    }

    // c. metoda walidacji danych
    public function validate() {

        if (! (isset($this->form->price) && isset($this->form->time) && isset($this->form->percentage))) {
            return false;
        }

        if ($this->form->price === '') {
            $this->msgs->addError('Nie podano wartości kredytu.');
        }
        if ($this->form->time === '') {
            $this->msgs->addError('Nie podano czasu spłaty kredytu.');
        }
        if ($this->form->percentage === '') {
            $this->msgs->addError('Nie podano oprocentowania.');
        }

        if ($this->msgs->isError()) return false;

        $this->form->price      = str_replace(',', '.', $this->form->price);
        $this->form->time       = str_replace(',', '.', $this->form->time);
        $this->form->percentage = str_replace(',', '.', $this->form->percentage);

        if (!is_numeric($this->form->price)) {
            $this->msgs->addError('Kwota kredytu musi być liczbą.');
        }
        if (!is_numeric($this->form->time)) {
            $this->msgs->addError('Okres spłaty (lata) musi być liczbą.');
        }
        if (!is_numeric($this->form->percentage)) {
            $this->msgs->addError('Oprocentowanie musi być liczbą.');
        }

        if ($this->msgs->isError()) return false;

        $this->form->price      = (float)$this->form->price;
        $this->form->time       = (float)$this->form->time;
        $this->form->percentage = (float)$this->form->percentage;

        if ($this->form->price <= 0) {
            $this->msgs->addError('Kwota kredytu musi być większa od zera.');
        }
        if ($this->form->time <= 0) {
            $this->msgs->addError('Okres spłaty (lata) musi być większy od zera.');
        }
        if ($this->form->percentage < 0) {
            $this->msgs->addError('Oprocentowanie nie może być ujemne.');
        }

        return ! $this->msgs->isError();
    }

    // e. metoda wykonująca obliczenia
    public function compute() {

        $n = (int)round($this->form->time * 12); 

        if ($n <= 0) {
            $this->msgs->addError('Okres spłaty po przeliczeniu na miesiące musi być dodatni.');
            return;
        }

        $r = ($this->form->percentage / 100.0) / 12.0; 

        if ($r == 0.0) {
            $payment = $this->form->price / $n;
        } else {
            $factor = pow(1 + $r, $n);
            $payment = $this->form->price * $r * $factor / ($factor - 1);
        }

        $this->result->monthlyPayment = number_format($payment, 2, ',', ' ');
        $this->msgs->addInfo('Obliczono miesięczną ratę.');
    }

    // d. metoda wyświetlenia widoku
    public function generateView() {
        global $smarty, $conf;

        $smarty->assign('form', $this->form);
        $smarty->assign('result', $this->result);
        $smarty->assign('msgs', $this->msgs);
        $smarty->display('CalcView.tpl');
    }

    // e. metoda procesu 
    public function process() {
        $this->getParams();

        if ($this->validate()) {
            $this->compute();
        }

        $this->generateView();
    }
}
