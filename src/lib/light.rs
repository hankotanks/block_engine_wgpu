pub(crate) const MAX_LIGHT_SOURCES: usize = 64;

#[repr(C)]
#[derive(Clone, Copy, bytemuck::Pod, bytemuck::Zeroable)]
pub(crate) struct Light {
    pub(crate) position: [f32; 4],
    pub(crate) color: [f32; 4]
}

impl Default for Light {
    fn default() -> Self {
        Self { position: [0.0; 4], color: [0.0; 4] }
    }
}

#[repr(C)]
#[derive(Clone, Copy, bytemuck::Pod, bytemuck::Zeroable)]
pub(crate) struct LightSources {
    pub(crate) light_uniforms: [Light; MAX_LIGHT_SOURCES]
}