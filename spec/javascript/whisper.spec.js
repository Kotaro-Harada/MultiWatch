import { mount, shallowMount } from '@vue/test-utils'
import Whisper from '../../app/javascript/vue/whisper.vue'
import 'jest'
import axios from 'axios'
import flushPromises from 'flush-promises'

jest.mock('axios', () => ({
  _esModule: true,
  default: jest.fn(() => Promise.resolve({ data: false })),
  get: jest.fn(() => Promise.resolve({ data: false })),
  post: jest.fn(() => Promise.resolve({ whisper: false})),
  delete: jest.fn(() => Promise.resolve({ data: false }))
}))

const MockFn = jest
  .fn(() => { throw new Error() })
  .mockImplementationOnce(() => { throw new Error("404") })
  .mockImplementationOnce(() => { throw new Error("422") })

afterEach(() => {
  jest.clearAllMocks()
})

describe("WhisperComponent", () => {
  const wrapper = mount(Whisper)
  const messageButton = wrapper.find("#message_button")
  test("whisper message", async() => {
    wrapper.find(".receive_user_name").setValue("multiwatch")
    wrapper.find("#message").setValue("Hello")
    messageButton.trigger("click")
    await flushPromises()
    expect(axios.post).toHaveBeenCalledWith("/api/v1/whispers", {
      "whisper": {"message": "Hello", "receive_user_name": "multiwatch"
    }})
    expect(messageButton.text()).toContain("送信しました")
  }),
  test("user is invalid", async() => {
    wrapper.find(".receive_user_name").setValue(false)
    wrapper.find("#message").setValue("Hello")
    messageButton.trigger("click")
    MockFn
    await flushPromises()
    expect(MockFn).toThrowError("404")
    expect(axios.post).toHaveBeenCalledWith("/api/v1/whispers", {
      "whisper": {"message": "Hello", "receive_user_name": "false"
    }})
  }),
  test("message is invalid", async() => {
    wrapper.find(".receive_user_name").setValue("multiwatch")
    wrapper.find("#message").setValue(false)
    messageButton.trigger("click")
    MockFn
    await flushPromises()
    expect(MockFn).toThrowError("422")
    expect(axios.post).toHaveBeenCalledWith("/api/v1/whispers", {
      "whisper": {"message": "false", "receive_user_name": "multiwatch"
    }})
  }),
  test("delete whisper", async() => {
    const jsdomConfirm = window.confirm
    window.confirm = jest.fn(() => Promise.resolve())
    wrapper.find(".clear_button").trigger("click")
    await flushPromises()
    expect(axios.delete).toHaveBeenCalledWith("/api/v1/whispers/destroy", {})
    window.confirm = jsdomConfirm
  }),
  test("confirm friend request", async() => {
    const wrapper = mount(Whisper, {
      data(){
        return{
          whispers: {
            whisper: {
              message_type: 1,
              send_user_id: 2,
              id: 3
            }
          },
          index: 0
        }
      }
    })
    wrapper.find(".confirm_button").trigger("click")
    await flushPromises()
    expect(axios.post).toHaveBeenCalledWith("/friendships", {
      "friendship": {
        "from_user_id": 2
      },
      "id": 3,
    })
    MockFn
    await flushPromises()
    expect(MockFn).not.toHaveBeenCalled()
  }),
  test("join chat", async() => {
    const wrapper = mount(Whisper, {
      data(){
        return{
          whispers: {
            whisper: {
              message_type: 2,
              send_user_id: 2,
              id: 3
            }
          },
          index: 0
        }
      }
    })
    wrapper.find(".join_button").trigger("click")
    await flushPromises()
    expect(axios.post).toHaveBeenCalledWith("/rooms/add_user", {
      "user_id": 2,
      "whisper_id": 3
    })
    MockFn
    await flushPromises()
    expect(MockFn).not.toHaveBeenCalled()
  }),
  test("reload whisper", async() => {
    wrapper.find(".reload_button").trigger("click")
    await flushPromises()
    expect(axios.get).toHaveBeenCalledWith("/api/v1/whispers")
  }),
  test("get whisper when component is mounted", async() => {
    const wrapper = mount(Whisper)
    await flushPromises()
    expect(axios.get).toHaveBeenCalledWith("/api/v1/whispers")
  })
})
