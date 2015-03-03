---
---

SacralHealing = angular.module 'SacralHealing', [], ($interpolateProvider)->
  $interpolateProvider.startSymbol('//')
  $interpolateProvider.endSymbol('//')

SacralHealing.filter 'shuffle', ->
  shuffledArr = []
  shuffledLength = 0
  
  (arr)->
    o = arr
    if shuffledLength == arr.length
      return shuffledArr
    
    j = undefined
    x = undefined
    i = o.length

    while i
      j = parseInt(Math.random() * i)
      x = o[--i]
      o[i] = o[j]
      o[j] = x
    
    shuffledArr = o
    shuffledLength = o.length
    o

SacralHealing.controller 'WelcomeController', ['$scope', '$timeout', '$filter', ($scope, $timeout, $filter)->
  content = document.getElementById('content')
  if content
    $scope.move = (state)->
      if !state
        content.scrollTop += 100
    
      else
        content.scrollTop -= 100
  
  footer = document.getElementById('footer-wrapper')
  if footer
    angularFooter = angular.element footer
    footerChildren = $filter('shuffle')(angularFooter.children())
    angularFooter.empty()
    angularFooter.append(footerChildren)
  
    $scope.run = ->
      footer.scrollLeft += 1
    
      $timeout ->
        if (footer.scrollLeft + footer.offsetWidth) != footer.scrollWidth
          $scope.run()
        else
          footer.scrollLeft = 0
          $scope.run()
      , 25
  
    $scope.run()
]