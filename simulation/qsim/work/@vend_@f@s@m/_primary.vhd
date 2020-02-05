library verilog;
use verilog.vl_types.all;
entity Vend_FSM is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        coin            : in     vl_logic_vector(1 downto 0);
        choice          : in     vl_logic_vector(3 downto 0);
        cancel          : in     vl_logic;
        state           : out    vl_logic_vector(2 downto 0);
        vend            : out    vl_logic_vector(3 downto 0);
        change          : out    vl_logic_vector(2 downto 0)
    );
end Vend_FSM;
