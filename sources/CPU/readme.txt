--  2016.12.17
--  福永祐真

--  全て非同期式リセット
    UART_TXに0を代入するため...etc

--  ROMをmifファイルで初期化するには
    Device > Configuration > 
    Configuration mode : Single Compressed Image with Initialization(256Kbits UFM)
    を選択する。

--  ROMデータがmifファイルで初期化されない場合は
    プロジェクトを新規作成し、ROM1portでfetch.vhdを生成する。
    信号は4つ
    address
    inclock
    outclock
    q