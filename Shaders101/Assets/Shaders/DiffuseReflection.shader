// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Shaders101/Lighting/DiffuseReflection"
{
	Properties
	{
		_Color ("Color", COLOR) = (1.0, 1.0, 1.0, 1.0)
	}
	SubShader
	{
        Tags{ "LightMode" = "ForwardBase" }      
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

            uniform float4 _LightColor0;
            uniform float4 _Color;

            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 col : COLOR;
            };

            vertexOutput vert(vertexInput input)
            {
                vertexOutput output;

                float4x4 modelMatrix = unity_ObjectToWorld;
                float4x4 modelMatrixInverse = unity_WorldToObject;

                float3 normalDirection = normalize(mul(float4(input.normal, 0.0), modelMatrixInverse).xyz);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);

                float3 diffuseReflection = _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection , lightDirection));

                output.col = float4(diffuseReflection , 1.0);
                output.pos = UnityObjectToClipPos(input.vertex); 

                return output;
            }

            float4 frag(vertexOutput input) : COLOR
            {
                return input.col;
            }

			ENDCG
		}
	}
    Fallback "Diffuse"
}
