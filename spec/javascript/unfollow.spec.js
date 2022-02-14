import { mount, shallowMount } from '@vue/test-utils'
import UnFollow from '../../app/javascript/vue/unfollow.vue'
import 'jest'
import axios from 'axios'
import flushPromises from 'flush-promises'

jest.mock('axios', () => ({
  _esModule: true,
  default: jest.fn(() => Promise.resolve({ data: false })),
  get: jest.fn(() => Promise.resolve({ data: false })),
  post: jest.fn(() => Promise.resolve({ data: false})),
  delete: jest.fn(() => Promise.resolve({ data: false }))
}))

const MockFn = jest
  .fn(() => { throw new Error() })

afterEach(() => {
  jest.clearAllMocks()
})

describe("UnFollowComponent", () => {
  test("get follow channels when component is mounted", async() => {
    const wrapper = mount(UnFollow)
    await flushPromises()
    expect(axios.get).toHaveBeenCalledWith("/follows")
  }),
  test("unfollow channel", async() => {
    const wrapper = mount(UnFollow, {
      data(){
        return {
          follows: {
            follow: {
              channel_id: 1
            }
          }
        }
      }
    })
    wrapper.find(".side_unfollow").trigger("click")
    await flushPromises()
    expect(axios.delete).toHaveBeenCalledWith("/follows/destroy", {
      params: {
        channel_id: 1
      }
    })
  }),
  test("fail unfollow", async() => {
    MockFn
    await flushPromises()
    expect(MockFn).not.toHaveBeenCalled()
  })
})
