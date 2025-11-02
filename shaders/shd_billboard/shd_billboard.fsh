precision mediump float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_WorldPos;

uniform vec3  u_CamPos;           // player eye
uniform float u_FogStart;         // start of fade
uniform float u_FogEnd;           // end of fade
uniform float u_MinBright;        // optional color darken at far (0..1)
uniform float u_MinAlpha;         // alpha at far distance 0.1..0.4)

void main() {
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord);
    if (tex.a <= 0.0) discard;

    float dist = distance(v_WorldPos, u_CamPos);
    float t = clamp((dist - u_FogStart) / max(1.0, (u_FogEnd - u_FogStart)), 0.0, 1.0);

    // Optional brightness falloff
    float br = mix(1.0, u_MinBright, t);

    // Alpha fade: 1.0 near → u_MinAlpha far
    float a = mix(1.0, u_MinAlpha, t);

    vec3 rgb = tex.rgb * v_vColour.rgb * br;
    gl_FragColor = vec4(rgb, tex.a * v_vColour.a * a);
}


