Shader "Custom/Union"
{

    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _Start ("Line start", float) = 0.5
        _Width ("Line width", float) = 0.1
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
            float _Start;
            float _Width;

            vertOutput vert(vertInput v)
            {
                vertOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float drawLine(float2 uv, float start, float width)
            {
                if ((uv.x > start && uv.x < start + width) || (uv.y > start && uv.y < start + width))
                {
                    return 1;
                }
                return 0;
            }

            float4 frag(vertOutput i) : SV_TARGET
            {
                float4 color = _Color;
                color.a = drawLine(i.uv, _Start, _Width) * _Color.a;
                return color;
            }

            ENDCG
        }
    }

}
