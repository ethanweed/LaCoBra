**Hypothesis Testing**

<style>
.container{
  display: flex;
}
.col {
  flex: 1;
}
</style>
---

**Research hypotheses versus statistical hypotheses**


- My research hypothesis: “ESP exists”

- My statistical hypothesis: 𝜃≠0.5

---

**Null hypotheses and alternative hypotheses**

---

**Two types of errors**

::: {.container}
:::: {.col}

|             | retain H0        | reject H0        |
|-------------|------------------|------------------|
| H0 is true  | correct decision | error (type I)   |
| H0 is false | error (type II)  | correct decision |

::::
:::


---

|             | retain H0                                     | reject H0                     |
|-------------|-----------------------------------------------|-------------------------------|
| H0 is true  | $1-\alpha$ (probability of correct retention) | $\alpha$ (type I error rate)  |
| H0 is false | $\beta$ (type II error rate)                  | $1-\beta$  (power of the test)|

---

**One-sample t-test**

                    </p>
                    <dl>
                        <dd>
                            <span class="mwe-math-element">
                                <span class="mwe-math-mathml-inline mwe-math-mathml-a11y" style="display: none;">
                                    <math xmlns="http://www.w3.org/1998/Math/MathML" alttext="{\displaystyle t={\frac {{\bar {x}}-\mu _{0}}{s/{\sqrt {n}}}}}">
                                        <semantics>
                                            <mrow class="MJX-TeXAtom-ORD">
                                                <mstyle displaystyle="true" scriptlevel="0">
                                                    <mi>t</mi>
                                                    <mo>=</mo>
                                                    <mrow class="MJX-TeXAtom-ORD">
                                                        <mfrac>
                                                            <mrow>
                                                                <mrow class="MJX-TeXAtom-ORD">
                                                                    <mrow class="MJX-TeXAtom-ORD">
                                                                        <mover>
                                                                            <mi>x</mi>
                                                                            <mo stretchy="false">
                                                                                &#x00AF;<!-- ¯ -->
                                                                            </mo>
                                                                        </mover>
                                                                    </mrow>
                                                                </mrow>
                                                                <mo>
                                                                    &#x2212;<!-- − -->
                                                                </mo>
                                                                <msub>
                                                                    <mi>
                                                                        &#x03BC;<!-- μ -->
                                                                    </mi>
                                                                    <mrow class="MJX-TeXAtom-ORD">
                                                                        <mn>0</mn>
                                                                    </mrow>
                                                                </msub>
                                                            </mrow>
                                                            <mrow>
                                                                <mi>s</mi>
                                                                <mrow class="MJX-TeXAtom-ORD">
                                                                    <mo>/</mo>
                                                                </mrow>
                                                                <mrow class="MJX-TeXAtom-ORD">
                                                                    <msqrt>
                                                                        <mi>n</mi>
                                                                    </msqrt>
                                                                </mrow>
                                                            </mrow>
                                                        </mfrac>
                                                    </mrow>
                                                </mstyle>
                                            </mrow>
                                            <annotation encoding="application/x-tex">{\displaystyle t={\frac {{\bar {x}}-\mu _{0}}{s/{\sqrt {n}}}}}</annotation>
                                        </semantics>
                                    </math>
                                </span>
                                <img src="https://wikimedia.org/api/rest_v1/media/math/render/svg/6568a8744ea852a3d1a0cc5e2080723217b4b7ba" class="mwe-math-fallback-image-inline" aria-hidden="true" style="vertical-align: -2.838ex; width:11.4ex; height:6.176ex;" alt="{\displaystyle t={\frac {{\bar {x}}-\mu _{0}}{s/{\sqrt {n}}}}}"/>
                            </span>
                        </dd>
                    </dl>
                    <p>
	
---