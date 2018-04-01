Shader "Shaders101/ShadingInWorldSpace"
{
	Properties
	{
		_NearColor("Near Color", Color) = (1,1,1,1)
		_FarColor("Far Color", Color) = (0,0,0,1)
		_Distance("Distance", float) = 2.0
	}

	SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct vertexInput 
			{
				float4 vertex : POSITION;
			};

			struct vertexOutput 
			{
				float4 pos : SV_POSITION;
				float4 position_in_world_space : TEXCOORD0;
			};

			vertexOutput vert(vertexInput input)
			{
				vertexOutput output;
				output.pos = UnityObjectToClipPos(input.vertex);
				output.position_in_world_space = mul(unity_ObjectToWorld, input.vertex);
				return output;
			}

			fixed4 _NearColor;
			fixed4 _FarColor;
			float _Distance;

			float4 frag(vertexOutput input) : COLOR
			{
				float dist = distance(input.position_in_world_space, _FarColor);
				
				if (dist < _Distance)
				{
					return _NearColor;
				}
				else
				{
					return _FarColor;
				}
			}

			ENDCG
		}
	}
}
