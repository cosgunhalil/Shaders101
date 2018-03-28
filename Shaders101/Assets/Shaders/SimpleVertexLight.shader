
Shader "Shaders101/SimpleVertexLight"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
	}

		SubShader
		{
			Pass
			{
				Tags{ "LightMode" = "ForwardBase" }

				CGPROGRAM

				#pragma vertex vert             
				#pragma fragment frag

				#include "UnityCG.cginc"

				uniform half4 _Color;
				uniform float4 _LightColor0;

				struct vertInput
				{
					float4 pos : POSITION;
					float3 nor : NORMAL;
				};

				struct vertOutput
				{
					float4 pos : SV_POSITION;
					half4 col : COLOR;
				};

				vertOutput vert(vertInput input)
				{
					vertOutput o;

					float4 normal = float4(input.nor, 0.0);
					float3 n = normalize(mul(normal, unity_WorldToObject));
					float3 l = normalize(_WorldSpaceLightPos0);

					float3 NdotL = max(0.0, dot(n, l));

					float3 d = NdotL * _LightColor0 * _Color;
					o.col = float4(d, 1.0);
					o.pos = UnityObjectToClipPos(input.pos);

					return o;
				}

				half4 frag(vertOutput input) : COLOR
				{
					return saturate(input.col);
				}

				ENDCG
			}
		}
}
