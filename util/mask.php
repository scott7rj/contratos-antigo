<?php
// PHP MÃ¡scara CNPJ, CPF, Data e qualquer outra coisa
// http://blog.clares.com.br/php-mascara-cnpj-cpf-data-e-qualquer-outra-coisa/
// ver em funcionamento ~~> https://ideone.com/wP7zN2


function mask($val, $mask) {
    $maskared = '';
    $k = 0;

    for ($i = 0; $i <= strlen($mask) - 1; ++$i) {
        if ($mask[$i] == '#') {
            if (isset($val[$k])) {
                $maskared .= $val[$k++];
            }
        } else {
            if (isset($mask[$i])) {
                $maskared .= $mask[$i];
            }
        }
    }

    return $maskared;
}
/*
$cnpj = '11222333000199';
$cpf = '00100200300';
$cep = '08665110';
$data = '10102010';
$hora = '021050';

echo mask($cnpj, '##.###.###/####-##').'<br>';
echo mask($cpf, '###.###.###-##').'<br>';
echo mask($cep, '#####-###').'<br>';
echo mask($data, '##/##/####').'<br>';
echo mask($data, '##/##/####').'<br>';
echo mask($data, '[##][##][####]').'<br>';
echo mask($data, '(##)(##)(####)').'<br>';
echo mask($hora, 'Agora sÃ£o ## horas ## minutos e ## segundos').'<br>';
echo mask($hora, '##:##:##');
*/
