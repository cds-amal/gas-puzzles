// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedArraySort {
    function sortArray(uint256[] memory data) external pure returns (uint256[] memory) {
        uint256 length = data.length;
        uint256 length_minus_1 = data.length - 1;
        uint256 min;
        for (uint256 i = 0; i < length_minus_1; i++) {
            min = i;
            for (uint256 j = i+1; j < length; j++) {
                if(data[min] > data[j]) {
                    min = j;
                }
            }
            // do only one swap, if needed
            if (min != i) {
                (data[i], data[min]) = (data[min], data[i]);
            }
        }
        return data;
    }
}
