library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity top_asip is
    generic (
        threshold_limit : std_logic_vector(PWM_WIDTH - 9 downto 0) := "000000100000"
    );
    port ( 
        clk     : in    std_logic;
        rst     : in    std_logic;
        echo    : in    std_logic;
        dig_in  : in    std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
        dig_out : out   std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
        trig    : out   std_logic
    );
end top_asip;

architecture arch of top_asip is
    signal dr_wr_ctr    :   std_logic;
    signal dm_wr_ctr    :   std_logic;
    signal alu_zero     :   std_logic;
    signal pc_mux_ctr   :   std_logic;
    signal alu_mux_ctr  :   std_logic;
    signal dreg_mux_ctr :   std_logic;
    signal pc_din       :   std_logic_vector(PC_DATA_WIDTH - 1 downto 0);
    signal pc_dout      :   std_logic_vector(PC_DATA_WIDTH - 1 downto 0);
    signal opcd_out     :   std_logic_vector(IM_DATA_WIDTH - 1 downto 0);
    signal immediate    :   std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
    signal dr1_dout     :   std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
    signal dr2_dout     :   std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
    signal alu_mux_out  :   std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
    signal alu_dout     :   std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
    signal dm_dout      :   std_logic_vector(DM_DATA_WIDTH - 1 downto 0);
    signal dr_mux_out   :   std_logic_vector(DM_DATA_WIDTH - 1 downto 0);
    signal alu_ctr_in   :   std_logic_vector(OPCODE_WIDTH - 1 downto 0);
    signal in_mux_ctr   :   std_logic;
    signal out_reg_wr   :   std_logic;
    signal in_mux_out   :   std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
    
    -- Echo sensor
    signal write        :   std_logic;
    signal threshold    :   std_logic_vector(PWM_WIDTH - 1 downto 0);
    signal over_limit   :   std_logic;
    signal width_count  :   std_logic_vector(PWM_WIDTH - 1 downto 0);
begin
    -- Program Counter
    pc : entity work.pc(arch)
    port map (
        clk             => clk,
        rst             => rst,
        pc_din          => pc_din,
        pc_dout         => pc_dout
    );
    
    -- Instruction Memory
    imem : entity work.imem(arch)
    port map (
        im_addr         => pc_dout(IM_ADDR_WIDTH - 1 downto 0),
        im_dout         => opcd_out
    );
    
    -- Data registers
    dreg : entity work.dreg(arch)
    port map (
        clk             => clk,
        dr_wr_ctr       => dr_wr_ctr,
        dwr_addr        => opcd_out(9 downto 7),
        dr1_addr        => opcd_out(12 downto 10),
        dr2_addr        => opcd_out(15 downto 13),
        dwr_din         => in_mux_out,
        dr1_dout        => dr1_dout,
        dr2_dout        => dr2_dout
    );
    
    -- Arithmetic Logic Unit
    alu : entity work.alu(arch)
    port map (
        alu_din_hi      => dr1_dout,
        alu_din_lo      => alu_mux_out,
        alu_ctr_in      => alu_ctr_in,
        alu_dout        => alu_dout,
        alu_zero        => alu_zero
    );
    
    -- Data Memory
    dmem : entity work.dmem(arch)
    port map (
        clk             => clk,
        dm_wr_ctr       => dm_wr_ctr,
        dm_addr         => alu_dout,
        dm_din          => dr2_dout,
        dm_dout         => dm_dout
    );
    
    -- Control Path
    control_asip : entity work.control_asip(arch)
    port map (
        clk             => clk,
        rst             => rst,
        alu_zero        => alu_zero,
        pc_mux_ctr      => pc_mux_ctr,
        alu_mux_ctr     => alu_mux_ctr,
        dreg_mux_ctr    => dreg_mux_ctr,
        in_mux_ctr      => in_mux_ctr,
        out_reg_write   => out_reg_wr,
        opcode          => opcd_out(OPCODE_WIDTH - 1 downto 0), 
        dreg_write      => dr_wr_ctr, 
        dmem_write      => dm_wr_ctr,
        alu_ctr         => alu_ctr_in
    );
    
    -- Modulus M Counter
--    mod_m_counter : entity work.mod_m_counter(arch)
--    port map (
--        clk             => clk,
--        rst             => rst,
--        max_tick        => ,
--        mc_q            => dig_out
--    );
    
    -- Output Register
    out_reg : entity work.reg_dr(arch)
    port map (
        clk             => clk,
        rst             => rst,
        reg_ld          => out_reg_wr,
        reg_d           => dr2_dout,
        reg_q           => dig_out
    );
    
    -- Echo Sensor
    top_echo : entity work.top_echo(arch)
    port map (
        clk             => clk,
        rst             => rst,
        write           => write,
        echo            => echo,
        threshold       => threshold,
        above_limit      => over_limit,
        width_count     => width_count,
        trigger         => trig
    );
    
    immediate <= opcd_out(IM_DATA_WIDTH - 1 downto 16);
    
    -- Glue pc_mux
    pc_din <= 
        std_logic_vector(unsigned(pc_dout) + 1)                     when pc_mux_ctr = '1' else
        std_logic_vector(unsigned(pc_dout) + unsigned(immediate))   when opcd_out(IM_DATA_WIDTH - 1) = '0' else
        std_logic_vector(unsigned(pc_dout) - not(unsigned(immediate) - 1));

    -- Glue alu_mux
    alu_mux_out <= immediate when alu_mux_ctr = '1' else dr2_dout;
    
    -- Glue dr_mux
    dr_mux_out <= alu_dout when dreg_mux_ctr = '1' else dm_dout;
    
    -- Glue in_mux
    in_mux_out <= dig_in when in_mux_ctr = '1' else dr_mux_out;
    
    -- Concatenate threshold limit
    threshold   <= threshold_limit & dr2_dout;
    
end arch;