precision highp float;

struct DirectionalLight
{
	vec3 position;
	vec3 direction;
	vec3 color;
};

varying vec3 fragColor;
varying vec3 fragNormal;
varying vec2 fragTexCoord;

varying vec3 toLightDirection;
varying vec3 toCameraDirection;

uniform float alpha;
uniform float shininess;
uniform float reflectivity;

uniform sampler2D Sampler;
uniform vec3 ambientLightIntensity;
uniform DirectionalLight sun;

void main()
{
	vec4 texel = texture2D(Sampler, fragTexCoord);
	vec3 normal = normalize(fragNormal);
	vec3 direction = normalize(sun.direction);
	vec3 toLight = normalize(toLightDirection);
	vec3 toCamera = normalize(toCameraDirection);
	vec3 reflected = reflect(-toLight, normal);

	float specularFactor = dot(reflected, toCamera);
	specularFactor = max(specularFactor, 0.0);
	float hardness = pow(specularFactor, shininess);
	vec3 specular = hardness * reflectivity * sun.color;

    vec3 lightIntensity = ambientLightIntensity + sun.color * max(dot(normalize(normal), normalize(direction)), 0.0);

    gl_FragColor = vec4(fragColor, alpha) * vec4(texel.rgb * lightIntensity, alpha) + vec4(specular, alpha);
}