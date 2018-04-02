// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shaders101/Transparency"
{
    Properties
    {
        _Color("Color",Color) = (1.0, 1.0, 1.0, 1.0)
    }
	SubShader
	{      
		Pass
		{
			 ZWrite Off
             Blend SrcAlpha OneMinusSrcAlpha // alpha blending

             CGPROGRAM 
     
             #pragma vertex vert 
             #pragma fragment frag

             float4 _Color;

             float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
             {
                return UnityObjectToClipPos(vertexPos);
             }
     
             float4 frag(void) : COLOR 
             {
                return float4(_Color.x, _Color.y, _Color.z, _Color.w);
             }
 
         ENDCG  
		}
	}
}
