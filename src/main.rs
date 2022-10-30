mod examples;
use examples::cgol::{
    CGOL_CONFIG,
    cgol_automata_init,
    cgol_state_function
};

use block_engine_wgpu::run;

fn main() {
    pollster::block_on(run(
        CGOL_CONFIG,
        cgol_automata_init(),
        cgol_state_function,
        &[(1, [1.0; 3])]
    ));
}
