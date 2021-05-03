Shader "Custom/Gradient"
{

    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
    }

    Subshader
    {
        Tags { "Queue" = "Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off

        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            struct vertInput
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct vertOutput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float4 _Color;

            vertOutput vert(vertInput v)
            {
                vertOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag(vertOutput i) : SV_TARGET
            {
                float4 color = _Color;
                color.a = i.uv.x * _Color.a;
                return color;
            }

            ENDCG
        }
    }

}
