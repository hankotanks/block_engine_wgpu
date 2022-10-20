struct CameraUniform {
    position: vec4<f32>,
    projection: mat4x4<f32>
};

@group(0) @binding(0)
var<uniform> camera: CameraUniform;

struct LightUniform {
    position: vec4<f32>,
    color: vec4<f32>
}

struct Lights {
    light_uniforms: array<LightUniform>
}

@group(1) @binding(0)
var<storage, read> lights: Lights;

struct VertexInput {
    @location(0) position: vec3<f32>,
    @location(1) color: vec3<f32>,
    @location(2) normal: vec3<f32>
};

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec3<f32>,
    @location(1) world_normal: vec3<f32>,
    @location(2) world_position: vec3<f32>
};

@vertex
fn vs_main(model: VertexInput) -> VertexOutput {
    var out: VertexOutput;
    out.clip_position = camera.projection * vec4<f32>(model.position, 1.0);
    out.color = model.color;
    out.world_normal = model.normal;
    out.world_position = model.position;
    
    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let ambient_color = light.color.xyz * light.color.a;
    let light_dir = normalize(light.position.xyz - in.world_position);
    let diffuse_strength = max(dot(in.world_normal, light_dir), 0.0);
    let diffuse_color = light.color.xyz * diffuse_strength;
    let view_dir = normalize(camera.position.xyz - in.world_position);
    let reflect_dir = reflect(-light_dir, in.world_normal);
    let specular_strength = pow(max(dot(view_dir, reflect_dir), 0.0), 32.0);
    let specular_color = light.color.xyz * specular_strength;

    let result = (ambient_color + diffuse_color + specular_color) * in.color;

    return vec4<f32>(result, 1.0);
}