library verilog;
use verilog.vl_types.all;
entity Vend_FSM_vlg_sample_tst is
    port(
        cancel          : in     vl_logic;
        choice          : in     vl_logic_vector(3 downto 0);
        clock           : in     vl_logic;
        coin            : in     vl_logic_vector(1 downto 0);
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Vend_FSM_vlg_sample_tst;
