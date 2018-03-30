// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shaders101/SimpleColor"
{
	Properties
	{
		_Color ("Main Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4 vert(float4 vertex : POSITION): SV_POSITION
			{
				return UnityObjectToClipPos(vertex);
			}

			fixed4 _Color;

			fixed4 frag() : SV_Target
			{
				return _Color;
			}
			
			ENDCG
		}
	}
}
