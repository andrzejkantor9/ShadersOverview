Shader "Mine/PassesAndBlending/BlendTest"
{
    Properties
    {
        _MainTexture ("Main Texutre", 2D) = "black" {}
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }

        //incoming color multiply, Frame buffer color multiplier
        //black = transparent
        // Blend One One
        //standard blend
        // Blend SrcAlpha OneMinusSrcAlpha
        //soft addtive - white = transparent
        Blend DstColor Zero

        Pass
        {
            SetTexture [_MainTexture] {combine texture }
        }
    }

    FallBack "Diffuse"
}