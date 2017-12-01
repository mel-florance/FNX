precision highp float;

struct DirectionalLight
{
	vec3 position;
	vec3 direction;
	vec3 color;
};

attribute vec3 position;
attribute vec3 normal;
attribute vec2 vertTexCoord;

varying vec3 fragColor;
varying vec3 fragNormal;
varying vec2 fragTexCoord;
varying vec3 toLightDirection;
varying vec3 toCameraDirection;

uniform mat4 mView;
uniform mat4 mProj;
uniform mat4 mTransform;
uniform mat4 mViewInverse;

uniform vec3 DiffuseColor;
uniform DirectionalLight sun;

void main()
{
	vec4 worldPosition = mTransform * vec4(position, 1.0);

    fragNormal = (mTransform * vec4(normal, 0.0)).xyz;
    fragColor = DiffuseColor;
    fragTexCoord = vertTexCoord;

	toLightDirection = sun.position - worldPosition.xyz;
	toCameraDirection = (mViewInverse * vec4(0.0, 0.0, 0.0, 1.0)).xyz - worldPosition.xyz;

    gl_Position = mProj * mView * worldPosition;
}