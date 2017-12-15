import React from 'react'
import { StyleSheet, Text, View, Button } from 'react-native'

export default class App extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      isLoading: true
    }
  }

  fetchShow () {
    fetch('https://api-staging.trakt.tv/shows/game-of-thrones?extended=full', {
      headers: {
        'Content-Type': 'application/json',
        'trakt-api-version': '2',
        'trakt-api-key': 'dc60acabe3d5d953393a0e332d8d7d3c5e3c7b7710158b5223526e79f1cf597a'
      }
    })
      .then(res => res.json())
      .then(res => console.log('res ', res))
      .catch(err => console.log('error ', err))
  }
  getShow () {
    fetch('http://192.168.1.2:3000/shows', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'token': 'V18A2txYHtwZrjMpZBzVqwBL',
        'Authentication': 'Token V18A2txYHtwZrjMpZBzVqwBL'
      },
      body:  JSON.stringify({
        "name": "Glee",
        "trakt_id": "uuuuu",
        "tvdb_id": "hhhhh",
        "image_url": "jjjkk"
      })
    })
  }
  // async fetchShow () {
  //   try {
  //     let response = await fetch(
  //       'https://api-staging.trakt.tv/shows/game-of-thrones?extended=full', {
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'trakt-api-version': '2',
  //           'trakt-api-key': 'dc60acabe3d5d953393a0e332d8d7d3c5e3c7b7710158b5223526e79f1cf597a'
  //         }
  //       })
  //     let responseJson = await response.json()
  //     return responseJson.shows
  //   } catch (error) {
  //     console.error(error)
  //   }
  // }

  render () {
    return (
      <View style={styles.container}>
        {/* <Text>Open App.js to start working on your app!</Text> */}
        <Text>Changes you make will automatically reload.</Text>
        <Text >Shake your phone to open the developer menu.</Text>
        <Button onPress={this.fetchShow.bind(this) } title='Press Me'>Press Me</Button>
        <Button onPress={this.getShow.bind(this) } title='Login'>Create</Button>
        {/* <Button onPress={this.fetchShows.bind(this) } title='Press Me'>Get Shows</Button> */}
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center'
  }
})
