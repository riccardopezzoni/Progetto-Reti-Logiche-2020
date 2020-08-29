----------------------------------------------------------------------------------
-- Prova Finale (Progetto di Reti Logiche) 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity project_reti_logiche is
    Port ( 
        i_clk       : in std_logic;
        i_start     : in std_logic;
        i_rst       : in std_logic;
        i_data      : in std_logic_vector(7 downto 0);
        o_address   : out std_logic_vector(15 downto 0);
        o_done      : out std_logic;
        o_en        : out std_logic;
        o_we        : out std_logic;
        o_data      : out std_logic_vector(7 downto 0)
    );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
    type state_type is (
        START,                     
        WAIT_RAM,
        GET_WZ,
        GET_ADDR,
        CALC_APP,
        WRITE_OUT,
        DONE,
        WAITING
    );
    signal STATE, P_STATE : state_type;
    
    
begin
    process (i_clk, i_rst)
    
-----------------------------------------------------
-----  VARIABILI-------------------------------------
-----------------------------------------------------
  
    
    variable wz0, wz1, wz2, wz3, wz4, wz5, wz6, wz7, endwz0, endwz1, endwz2, endwz3, endwz4, endwz5, endwz6, endwz7, ADDR : std_logic_vector(7 downto 0);
    variable address : std_logic_vector(15 downto 0);
    variable got_WZ0, got_WZ1, got_WZ2, got_WZ3, got_WZ4, got_WZ5, got_WZ6, got_WZ7 : boolean := false;
    variable appartiene : boolean := false;
    variable wz_num : std_logic_vector(2 downto 0);
    variable wz_offset :  std_logic_vector(3 downto 0);
        
    
begin
    if (i_rst = '1') then
    o_en <= '0';
    o_we <= '0';
    o_done <= '0';
    got_WZ0 := false;
    got_WZ1 := false;
    got_WZ2 := false;
    got_WZ3 := false;
    got_WZ4 := false;
    got_WZ5 := false;
    got_WZ6 := false;
    got_WZ7 := false;
    address := "0000000000000000";
    P_STATE <= START;
    STATE <= START;
    
    elsif (rising_edge(i_clk)) then
    
        case state is
        
            when START =>
                if (i_start = '1' AND  i_rst = '0') then
                o_address <=  "0000000000000000";
                o_en <= '1';
                o_we <= '0';
                STATE <= WAIT_RAM;
                P_STATE <= START;
                end if;
            
            when WAIT_RAM =>
                if (P_STATE = START) then
                    P_STATE <= WAIT_RAM;
                    STATE <= GET_WZ;
                elsif (P_STATE = GET_WZ) then
                    P_STATE <= WAIT_RAM;
                    if (got_WZ0 and got_WZ1 and got_WZ2 and got_WZ3 and got_WZ4 and got_WZ5 and got_WZ6 and got_WZ7) then
                        STATE <= GET_ADDR;
                    else 
                        STATE <= GET_WZ;
                    end if;                  
                elsif (P_STATE = GET_ADDR) then
                    P_STATE <= WAIT_RAM;
                    STATE <= CALC_APP;
                elsif (P_STATE = CALC_APP) then
                    P_STATE <= WAIT_RAM;
                    STATE <= WRITE_OUT;                                    
                elsif (P_STATE = WRITE_OUT) then
                    P_STATE <= WAIT_RAM;
                    STATE <= DONE;
                elsif (P_STATE = WAITING) then
                    P_STATE <= WAIT_RAM;
                    STATE <= GET_ADDR;
                end if;
                            
            when GET_WZ =>
                if (got_WZ0 = false) then
                    wz0 := i_data;
                    endwz0 := i_data + "00000011";
                    got_WZ0 := true;
                    o_address <=  "0000000000000001";
                    o_en <= '1';
                    STATE <= WAIT_RAM;
                    P_STATE <= GET_WZ;
                elsif (got_WZ1 = false) then
                    wz1 := i_data;
                    endwz1 := i_data + "00000011";
                    got_WZ1 := true;
                    o_address <=  "0000000000000010";
                    o_en <= '1';
                    STATE <= WAIT_RAM;
                    P_STATE <= GET_WZ;
                elsif (got_WZ2 = false) then
                    wz2 := i_data;
                    endwz2 := i_data + "00000011";
                    got_WZ2 := true;
                    o_address <=  "0000000000000011";
                    o_en <= '1';
                    STATE <= WAIT_RAM;
                    P_STATE <= GET_WZ;
                elsif (got_WZ3 = false) then
                    wz3 := i_data;
                    endwz3 := i_data + "00000011";
                    got_WZ3 := true;
                    o_address <=  "0000000000000100";
                    o_en <= '1';
                    STATE <= WAIT_RAM;
                    P_STATE <= GET_WZ;
                elsif (got_WZ4 = false) then
                    wz4 := i_data;
                    endwz4 := i_data + "00000011";
                    got_WZ4 := true;
                    o_address <=  "0000000000000101";
                    o_en <= '1';
                    STATE <= WAIT_RAM;
                    P_STATE <= GET_WZ;
                elsif (got_WZ5 = false) then
                    wz5 := i_data;
                    endwz5 := i_data + "00000011";
                    got_WZ5 := true;
                    o_address <=  "0000000000000110";
                    o_en <= '1';
                    STATE <= WAIT_RAM;
                    P_STATE <= GET_WZ;
                elsif (got_WZ6 = false) then
                    wz6 := i_data;
                    endwz6 := i_data + "00000011";
                    got_WZ6 := true;
                    o_address <=  "0000000000000111";
                    o_en <= '1';
                    STATE <= WAIT_RAM;
                    P_STATE <= GET_WZ;    
                elsif (got_WZ7 = false) then
                    wz7 := i_data;
                    endwz7 := i_data + "00000011";
                    got_WZ7 := true;
                    o_address <= "0000000000001000";
                    o_en <= '1';
                    STATE <= WAIT_RAM;
                    P_STATE <= GET_WZ;    
                end if;
                
                
            when GET_ADDR =>
                    ADDR := i_data;
                    STATE <= CALC_APP;
                    P_STATE <= GET_ADDR;
            
            
            when CALC_APP =>
                    if(wz0 <= ADDR and ADDR <= endwz0) then
                        wz_num := "000";
                        appartiene := true;
                        if (ADDR - wz0 = "0000") then 
                            wz_offset := "0001";
                        elsif (ADDR - wz0 = "0001") then
                            wz_offset := "0010";
                        elsif (ADDR - wz0 = "0010") then
                            wz_offset := "0100";
                        else
                            wz_offset := "1000";
                        end if;
                    elsif(wz1 <= ADDR and ADDR <= endwz1) then
                            wz_num := "001";
                            appartiene := true;
                            if (ADDR - wz1 = "0000") then 
                                wz_offset := "0001";
                            elsif (ADDR - wz1 = "0001") then
                                wz_offset := "0010";
                            elsif (ADDR - wz1 = "0010") then
                                wz_offset := "0100";
                            else
                                wz_offset := "1000";
                            end if;              
                    elsif(wz2 <= ADDR and ADDR <= endwz2) then
                                wz_num := "010";
                                appartiene := true;
                                if (ADDR - wz2 = "0000") then 
                                    wz_offset := "0001";
                                elsif (ADDR - wz2 = "0001") then
                                    wz_offset := "0010";
                                elsif (ADDR - wz2 = "0010") then
                                    wz_offset := "0100";
                                else
                                    wz_offset := "1000";
                                end if;                                               
                    elsif(wz3 <= ADDR and ADDR <= endwz3) then
                                wz_num := "011";
                                appartiene := true;
                                if (ADDR - wz3 = "0000") then 
                                    wz_offset := "0001";
                                elsif (ADDR - wz3 = "0001") then
                                    wz_offset := "0010";
                                elsif (ADDR - wz3 = "0010") then
                                    wz_offset := "0100";
                                else
                                    wz_offset := "1000";
                                end if;            
                    elsif(wz4 <= ADDR and ADDR <= endwz4) then
                                wz_num := "100";
                                appartiene := true;
                                if (ADDR - wz4 = "0000") then 
                                    wz_offset := "0001";
                                elsif (ADDR - wz4 = "0001") then
                                    wz_offset := "0010";
                                elsif (ADDR - wz4 = "0010") then
                                    wz_offset := "0100";
                                else
                                    wz_offset := "1000";
                                                        end if;            
                    elsif(wz5 <= ADDR and ADDR <= endwz5) then
                                wz_num := "101";
                                if (ADDR - wz5 = "0000") then 
                                    wz_offset := "0001";
                                elsif (ADDR - wz5 = "0001") then
                                    wz_offset := "0010";
                                elsif (ADDR - wz5 = "0010") then
                                    wz_offset := "0100";
                                else
                                    wz_offset := "1000";
                                end if;         
                    elsif(wz6 <= ADDR and ADDR <= endwz6) then
                                wz_num := "110";
                                appartiene := true;
                                if (ADDR - wz6 = "0000") then 
                                    wz_offset := "0001";
                                elsif (ADDR - wz6 = "0001") then
                                    wz_offset := "0010";
                                elsif (ADDR - wz6 = "0010") then
                                    wz_offset := "0100";
                                else
                                    wz_offset := "1000";
                                end if;         
                    elsif(wz7 <= ADDR and ADDR <= endwz7) then
                                wz_num := "111";
                                appartiene := true;
                                if (ADDR - wz7 = "0000") then 
                                    wz_offset := "0001";
                                elsif (ADDR - wz7 = "0001") then
                                    wz_offset := "0010";
                                elsif (ADDR - wz7 = "0010") then
                                    wz_offset := "0100";
                                else
                                    wz_offset := "1000";
                                end if;
                    end if;
                    STATE <= WRITE_OUT;
                    P_STATE <= CALC_APP;

            when WRITE_OUT => 
                if (appartiene = true) then
                    o_address <= "0000000000001001";
                    o_data <= '1' & wz_num & wz_offset;
                    o_we <= '1';
                    P_STATE <= WRITE_OUT;
                    STATE <= WAITING;
                elsif (appartiene  = false) then 
                    o_address <= "0000000000001001";
                    o_data <= ADDR;                                 -- sarebbe 0&ADDR ma ADDR è max 127
                    o_we <= '1';
                end if;
                P_STATE <= WRITE_OUT;
                STATE <= WAIT_RAM;

            when DONE =>
                o_en <= '0';
                o_we <= '0';
                o_done <= '1';
                STATE <= WAITING;
                
            when WAITING =>
                if (i_start = '1') then
                    STATE <= WAITING;
                elsif (i_start = '0') then
                    o_done <= '0';
                    o_address <= "0000000000001000";
                    o_en <= '1';                 
                    P_STATE <= WAITING;
                    STATE <= START;
                end if;
                
                
            end case; 
        end if;        
    end process;                 
end Behavioral;
