Shader "Shaders101/OrderIndependentBlending"
{
    Properties
    {
        _Color("Color",Color) = (1.0, 1.0, 1.0, 0.3)
    }
	SubShader
	{
		Pass
        {
            Cull Off
            ZWrite Off
            Blend Zero OneMinusSrcAlpha // multiplicative blending

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
                return _Color;
            }

            ENDCG
        }

        Pass
        {
            Cull Off
            ZWrite Off
            Blend SrcAlpha One // additive blending

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
                return _Color;
            }

            ENDCG
        }
	}
}
