attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

// Individual light uniforms (4 lights)
uniform vec3 lightPosition0;
uniform vec3 lightPosition1;
uniform vec3 lightPosition2;
uniform vec3 lightPosition3;

uniform vec4 lightColor0;
uniform vec4 lightColor1;
uniform vec4 lightColor2;
uniform vec4 lightColor3;

uniform float lightRange0;
uniform float lightRange1;
uniform float lightRange2;
uniform float lightRange3;

uniform int numLights;
uniform vec4 lightAmbient;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_worldPosition;

void main() 
{
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    // Keep this for fog (using WORLD_VIEW_PROJECTION like your working version)
    v_worldPosition = (gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos).xyz;
    
    // Lighting calculations
    vec3 worldPosition = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1.0)).xyz;
    vec3 worldNormal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz);
    
    // Start with ambient light
    vec4 totalLight = lightAmbient;
    
    // Light 0
    if (numLights > 0) {
        vec3 lightDir0 = lightPosition0 - worldPosition;
        float lightDist0 = length(lightDir0);
        lightDir0 = normalize(lightDir0);
        float att0 = max(1.0 - (lightDist0 * lightDist0) / (lightRange0 * lightRange0), 0.0);
        float diffuse0 = max(dot(worldNormal, lightDir0), 0.0);
        totalLight += att0 * lightColor0 * diffuse0;
    }
    
    // Light 1
    if (numLights > 1) {
        vec3 lightDir1 = lightPosition1 - worldPosition;
        float lightDist1 = length(lightDir1);
        lightDir1 = normalize(lightDir1);
        float att1 = max(1.0 - (lightDist1 * lightDist1) / (lightRange1 * lightRange1), 0.0);
        float diffuse1 = max(dot(worldNormal, lightDir1), 0.0);
        totalLight += att1 * lightColor1 * diffuse1;
    }
    
    // Light 2
    if (numLights > 2) {
        vec3 lightDir2 = lightPosition2 - worldPosition;
        float lightDist2 = length(lightDir2);
        lightDir2 = normalize(lightDir2);
        float att2 = max(1.0 - (lightDist2 * lightDist2) / (lightRange2 * lightRange2), 0.0);
        float diffuse2 = max(dot(worldNormal, lightDir2), 0.0);
        totalLight += att2 * lightColor2 * diffuse2;
    }
    
    // Light 3
    if (numLights > 3) {
        vec3 lightDir3 = lightPosition3 - worldPosition;
        float lightDist3 = length(lightDir3);
        lightDir3 = normalize(lightDir3);
        float att3 = max(1.0 - (lightDist3 * lightDist3) / (lightRange3 * lightRange3), 0.0);
        float diffuse3 = max(dot(worldNormal, lightDir3), 0.0);
        totalLight += att3 * lightColor3 * diffuse3;
    }
    
    v_vColour = in_Colour * vec4(min(totalLight.rgb, vec3(1.0)), in_Colour.a);
    v_vTexcoord = in_TextureCoord;
}