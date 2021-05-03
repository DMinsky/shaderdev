Shader "Custom/Texture"
{

    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _MainTex ("Main Texture", 2D) = "white" {}
    }

    Subshader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            struct vertInput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };

            struct vertOutput
            {
                float4 pos : SV_POSITION;
                float2 texcoord : TEXCOORD0; 
            };

            uniform float4 _Color;
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;

            vertOutput vert(vertInput v)
            {
                vertOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord = (v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
                return o;
            }

            float4 frag(vertOutput i) : SV_TARGET
            {
                return _Color * tex2D(_MainTex, i.texcoord);
            }

            ENDCG
        }
    }

}
