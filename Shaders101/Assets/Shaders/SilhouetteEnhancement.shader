﻿
Shader "Shaders101/SilhouetteEnhancement"
{
	Properties
	{
		_Color("Color",Color) = (1.0, 1.0, 1.0, 0.3)
	}
	SubShader
	{
        Tags{ "Queue" = "Transparent" }

		Pass
		{
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha // standard alpha blending

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

            #include "UnityCG.cginc"

            uniform float4 _Color;

            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD;
                float3 viewDir : TEXCOORD1;
            };

            vertexOutput vert(vertexInput input)
            {
                vertexOutput output;

                float4x4 modelMatrix = unity_ObjectToWorld;
                float4x4 modelMatrixInverse = unity_WorldToObject;

                output.normal = normalize(mul(float4(input.normal, 0.0), modelMatrixInverse).xyz);
                output.viewDir = normalize(_WorldSpaceCameraPos - mul(modelMatrix , input.vertex).xyz);

                output.pos = UnityObjectToClipPos(input.vertex);
                return output;
            }

            float4 frag(vertexOutput input) : COLOR
            {
                float3 normalDirection = normalize(input.normal);
                float3 viewDirection = normalize(input.viewDir);

                float newOpacity = min(1.0, _Color.a / abs(dot(viewDirection, normalDirection)));

                return float4(_Color.rgb, newOpacity);
            }

			ENDCG
		}
	}
}
