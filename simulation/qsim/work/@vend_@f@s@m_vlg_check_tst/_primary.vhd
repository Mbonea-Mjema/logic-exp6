library verilog;
use verilog.vl_types.all;
entity Vend_FSM_vlg_check_tst is
    port(
        change          : in     vl_logic_vector(2 downto 0);
        state           : in     vl_logic_vector(2 downto 0);
        vend            : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end Vend_FSM_vlg_check_tst;
