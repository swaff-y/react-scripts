#!/bin/bash

var=$1
upperCase="$(tr '[:lower:]' '[:upper:]' <<< ${var:0:1})${var:1}"
lowerCase="$(tr '[:upper:]' '[:lower:]' <<< ${var:0:1})${var:1}"

jsFile="$upperCase.js"
cssFile="$lowerCase.css"
testFile="$upperCase.test.js"
echo $jsFile
echo $cssFile
echo $testFile
# testFile=$(touch "$upperCase.test.js")
# cssFile=$(touch "$lowerCase.css")

# $("test") >> $jsFile
$(echo "import React, {useEffect, useState} from 'react';" >> $jsFile)
$(echo "import \"./$lowerCase.css\";" >> $jsFile)

$(echo "const $upperCase = (props) => {" >> $jsFile)
$(echo "   return(" >> $jsFile)
$(echo "    <div" >> $jsFile)
$(echo "      className=\"${lowerCase}__container\"" >> $jsFile)
$(echo "      data-test=\"component-$lowerCase\"" >> $jsFile)
$(echo "    >" >> $jsFile)
$(echo "    </div>" >> $jsFile)
$(echo "   )" >> $jsFile)
$(echo " }" >> $jsFile)
$(echo "" >> $jsFile)
$(echo "export default $upperCase" >> $jsFile)

$(echo ".${lowerCase}__container{" >> $cssFile)
$(echo "" >> $cssFile)
$(echo "}" >> $cssFile)

$(echo "import Enzyme, { shallow } from 'enzyme';" >> $testFile)
$(echo "import Adapter from '@wojtekmaj/enzyme-adapter-react-17';" >> $testFile)
$(echo "import React from 'react'" >> $testFile)
$(echo "import $upperCase from './$upperCase';" >> $testFile)
$(echo "import {findByAttr, findNode, findClass} from '../../testUtils'" >> $testFile)
$(echo "" >> $testFile)
$(echo "// set up enzyme's react adapter" >> $testFile)
$(echo "Enzyme.configure({ adapter: new Adapter});" >> $testFile)
$(echo "" >> $testFile)
$(echo "const setup = (props={}) => {" >> $testFile)
$(echo "    return shallow(<$upperCase {...props} />)" >> $testFile)
$(echo "};" >> $testFile)
$(echo "" >> $testFile)
$(echo "describe('<$upperCase /> component', () => {" >> $testFile)
$(echo "  it('renders without error', () => {" >> $testFile)
$(echo "    const wrapper = setup();" >> $testFile)
$(echo "    const component = findByAttr(wrapper,\"data-test\",\"component-$lowerCase\");" >> $testFile)
$(echo "    expect(component.length).toBe(1);" >> $testFile)
$(echo "  });" >> $testFile)
$(echo "});" >> $testFile)
