library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_reti_logiche is
    generic (
        START_ADDRESS : unsigned(MEM_BITS - 1 downto 0) := (others => '0') -- Indirizzo iniziale di memoria (dove è quindi salvata la maschera d'ingresso).
    );
    port (
        i_clk      : in  std_logic; -- Clock
        i_start    : in  std_logic; -- Il modulo parte nell'elaborazione quando il segnale START in ingresso viene portato a 1. Il segnale di START rimarrà alto fino a che il segnale di DONE non verrà portato alto.
        i_rst      : in  std_logic; -- Inizializza la macchina pronta per ricevere il primo segnale di start.
        i_data     : in  std_logic_vector(CELL_BITS - 1 downto 0); -- Segnale che arriva dalla memoria dopo richiesta di lettura.
        o_address  : out std_logic_vector(MEM_BITS - 1 downto 0); -- Indirizzo da mandare alla memoria, all'indirizzo 0 ho i primi 8 bit, all'indirizzo 1 altri 8 bit e così via.
        o_done     : out std_logic; -- Notifica la fine dell'elaborazione. Il segnale DONE deve rimanere alto fino a che il segnale di START non è riportato a 0.
        o_en       : out std_logic; -- Segnale di Enable da mandare alla memoria per poter comunicare (sia in lettura che in scrittura).
        o_we       : out std_logic; -- Write Enable. 1 per scrivere. 0 per leggere.
        o_data     : out std_logic_vector (CELL_BITS - 1 downto 0) -- Segnale da mandare alla memoria.
    );
end project_reti_logiche;

